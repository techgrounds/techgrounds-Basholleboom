@description('Size of VMs in the VM Scale Set.')
param vmSku string = 'Standard_A1'

@description(
  'The Ubuntu version for the VM. This will pick a fully patched image of this given Ubuntu version. Allowed values are: 15.10, 14.04.4-LTS.'
)
@allowed(['14.04.4-LTS', '16.04-LTS'])
param ubuntuOSVersion string = '16.04-LTS'

@description(
  'String used as a base for naming resources. Must be 3-61 characters in length and globally unique across Azure. A hash is prepended to this string for some resources, and resource-specific information is appended.'
)
@maxLength(61)
param vmssName string

@description('Number of VM instances (100 or less).')
@minValue(5)
@maxValue(100)
param instanceCount int

@description('Admin username on all VMs.')
param adminUsername string

@description('Default location')
param location string = resourceGroup().location

@description(
  'Type of authentication to use on the Virtual Machine. SSH key is recommended.'
)
@allowed(['sshPublicKey', 'password'])
param authenticationType string = 'sshPublicKey'

@description(
  'SSH Key or password for the Virtual Machine. SSH key is recommended.'
)
@secure()
param adminPasswordOrKey string

var namingInfix_var = toLower(
  substring(concat(vmssName, uniqueString(resourceGroup().id)), 0, 9)
)
var longNamingInfix = toLower(vmssName)
var addressPrefix = '10.0.0.0/16'
var subnetPrefix = '10.0.0.0/24'
var virtualNetworkName = '${namingInfix_var}vnet'
var publicIPAddressName = '${namingInfix_var}pip'
var subnetName = '${namingInfix_var}subnet'
var loadBalancerName = '${namingInfix_var}lb'
var publicIPAddressID = publicIPAddress.id
var natPoolName = '${namingInfix_var}natpool'
var bePoolName = '${namingInfix_var}bepool'
var natStartPort = 50000
var natEndPort = 50119
var natBackendPort = 22
var nicName = '${namingInfix_var}nic'
var ipConfigName = '${namingInfix_var}ipconfig'
var osType = {
  publisher: 'Canonical'
  offer: 'UbuntuServer'
  sku: ubuntuOSVersion
  version: 'latest'
}
var imageReference = osType
var linuxConfiguration = {
  disablePasswordAuthentication: true
  ssh: {
    publicKeys: [
      {
        path: '/home/${adminUsername}/.ssh/authorized_keys'
        keyData: adminPasswordOrKey
      }
    ]
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-08-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [addressPrefix]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
        }
      }
    ]
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2017-04-01' = {
  name: publicIPAddressName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    dnsSettings: {
      domainNameLabel: longNamingInfix
    }
  }
}

resource loadBalancer 'Microsoft.Network/loadBalancers@2017-04-01' = {
  name: loadBalancerName
  location: location
  properties: {
    frontendIPConfigurations: [
      {
        name: 'LoadBalancerFrontEnd'
        properties: {
          publicIPAddress: {
            id: publicIPAddressID
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: bePoolName
      }
    ]
    inboundNatPools: [
      {
        name: natPoolName
        properties: {
          frontendIPConfiguration: {
            id: resourceId(
              'Microsoft.Network/loadBalancers/frontendIPConfigurations',
              loadBalancerName,
              'loadBalancerFrontEnd'
            )
          }
          protocol: 'Tcp'
          frontendPortRangeStart: natStartPort
          frontendPortRangeEnd: natEndPort
          backendPort: natBackendPort
        }
      }
    ]
  }
}

resource namingInfix 'Microsoft.Compute/virtualMachineScaleSets@2017-03-30' = {
  name: namingInfix_var
  location: location
  sku: {
    name: vmSku
    tier: 'Standard'
    capacity: instanceCount
  }
  properties: {
    overprovision: 'true'
    upgradePolicy: {
      mode: 'Manual'
    }
    virtualMachineProfile: {
      storageProfile: {
        osDisk: {
          createOption: 'FromImage'
          caching: 'ReadWrite'
        }
        imageReference: imageReference
      }
      osProfile: {
        computerNamePrefix: namingInfix_var
        adminUsername: adminUsername
        adminPassword: adminPasswordOrKey
        linuxConfiguration: ((authenticationType == 'password')
          ? json('null')
          : linuxConfiguration)
      }
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: nicName
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: ipConfigName
                  properties: {
                    subnet: {
                      id: resourceId(
                        'Microsoft.Network/virtualNetworks/subnets/',
                        virtualNetworkName,
                        subnetName
                      )
                    }
                    loadBalancerBackendAddressPools: [
                      {
                        id: resourceId(
                          'Microsoft.Network/loadBalancers/backendAddressPools/',
                          loadBalancerName,
                          bePoolName
                        )
                      }
                    ]
                    loadBalancerInboundNatPools: [
                      {
                        id: resourceId(
                          'Microsoft.Network/loadBalancers/inboundNatPools/',
                          loadBalancerName,
                          natPoolName
                        )
                      }
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
    }
  }
  dependsOn: [loadBalancer, virtualNetwork]
}

resource autoscalewad 'Microsoft.Insights/autoscaleSettings@2015-04-01' = {
  name: 'autoscalewad'
  location: location
  properties: {
    name: 'autoscalewad'
    targetResourceUri: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Compute/virtualMachineScaleSets/${namingInfix_var}'
    enabled: true
    profiles: [
      {
        name: 'Profile1'
        capacity: {
          minimum: '1'
          maximum: '10'
          default: '1'
        }
        rules: [
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Compute/virtualMachineScaleSets/${namingInfix_var}'
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: 60
            }
            scaleAction: {
              direction: 'Increase'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT1M'
            }
          }
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Compute/virtualMachineScaleSets/${namingInfix_var}'
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'LessThan'
              threshold: 30
            }
            scaleAction: {
              direction: 'Decrease'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT5M'
            }
          }
        ]
      }
    ]
  }
  dependsOn: [namingInfix]
}
