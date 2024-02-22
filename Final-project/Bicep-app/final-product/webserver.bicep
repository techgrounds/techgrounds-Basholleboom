@description('Size of VMs in the VM Scale Set.')
param vmSku string = 'Standard_D2s_v3'

@description('The linux version for the VM. This will pick a fully patched image of this given Linux version.')
@allowed([
  'Ubuntu-1804'
  'Ubuntu-2004'
  'Ubuntu-2204'
])
param linuxOSVersion string = 'Ubuntu-2004'

@description('Security Type of the Virtual Machine.')
@allowed([
  'Standard'
  'TrustedLaunch'
])
param securityType string = 'TrustedLaunch'

@description('String used as a base for naming resources. Must be 3-57 characters in length and globally unique across Azure. A hash is prepended to this string for some resources, and resource-specific information is appended.')
@maxLength(57)
param vmssName string = 'webvmss'

@description('Number of VM instances (1000 or less).')
@minValue(1)
@maxValue(5)
param instanceCount int = 2

@description('Admin username on all VMs.')
param adminUsername string = 'Mainadmin'

@description('Default location')
param location string = resourceGroup().location

@description('Admin password on all VMs.')
@secure()
param adminPassword string

//param VirtualMachineNetworkSecurityGroupId string = '/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/nsgtest/providers/Microsoft.Network/networkSecurityGroups/man-NSG'

var securityProfileJson = {
  uefiSettings: {
    secureBootEnabled: true
    vTpmEnabled: true
  }
  securityType: securityType
}
var vmScaleSetName = toLower(substring('${vmssName}${uniqueString(resourceGroup().id)}', 0, 9))
var addressPrefix = '10.0.0.0/16'
var subnetPrefix = '10.0.8.0/21'
var virtualNetworkName = 'webvnet'
var subnetName = '${vmScaleSetName}subnet'
var nicName = '${vmScaleSetName}nic'
var ipConfigName = '${vmScaleSetName}ipconfig'
var osType = {
  'Ubuntu-1804': {
    publisher: 'Canonical'
    offer: 'UbuntuServer'
    sku: '18_04-lts-gen2'
    version: 'latest'
  }
  'Ubuntu-2004': {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-focal'
    sku: '20_04-lts-gen2'
    version: 'latest'
  }
  'Ubuntu-2204': {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-jammy'
    sku: '22_04-lts-gen2'
    version: 'latest'
  }
}
var imageReference = osType

var appGwPublicIPAddressName = '${vmScaleSetName}appGwPip'
var appGwName = '${vmScaleSetName}appGw'
var appGwSubnetName = '${vmScaleSetName}appGwSubnet'
var appGwSubnetPrefix = '10.0.1.0/24'
var appGwFrontendPort = 80
var appGwBackendPort = 80
var appGwBePoolName = '${vmScaleSetName}appGwBepool'
var networkSecurityGroupName = 'web-NSG'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
        }
      }
      {
        name: appGwSubnetName
        properties: {
          addressPrefix: appGwSubnetPrefix
          networkSecurityGroup:{
            id: networkSecurityGroup.id
          }
        }
      }
    ]
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
            {
        name: 'allow-ssh'
        properties: {
          priority: 1001
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '22'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '10.10.10.0' // Replace with the actual NSG ID of your VM
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'allow-rdp'
        properties: {
          priority: 1002
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '3389'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '10.10.10.0' // Replace with the actual NSG ID of your VM
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'appgatewayallow'
        properties:{
          access: 'Allow'
          direction: 'Inbound'
          priority: 1003
          protocol: 'Tcp'
          destinationPortRange: '65200 - 65535'
          destinationAddressPrefix: '*'
          sourcePortRange:'*'
          sourceAddressPrefix: '*'
        }
      }
      {
        name: 'httpallow'
        properties:{
          access: 'Allow'
          direction: 'Inbound'
          priority: 1004
          protocol: 'Tcp'
          destinationPortRange: '80'
          destinationAddressPrefix: '*'
          sourcePortRange:'*'
          sourceAddressPrefix: '*'
        }
      }
      {
        name: 'httpsallow'
        properties:{
          access: 'Allow'
          direction: 'Inbound'
          priority: 1005
          protocol: 'Tcp'
          destinationPortRange: '443'
          destinationAddressPrefix: '*'
          sourcePortRange:'*'
          sourceAddressPrefix: '*'
        }
      }
    ]
  }
}

resource appGwPublicIPAddress 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: appGwPublicIPAddressName
  location: location
  sku:{
    name:'Standard'
    tier:'Regional'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource appGw 'Microsoft.Network/applicationGateways@2022-11-01' = {
  name: appGwName
  location: location
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
      capacity: 10
    }
    gatewayIPConfigurations: [
      {
        name: 'appGwIpConfig'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, appGwSubnetName)
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGwFrontendIP'
        properties: {
          publicIPAddress: {
            id: appGwPublicIPAddress.id
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'appGwFrontendPort'
        properties: {
          port: appGwFrontendPort
        }
      }
    ]
    backendAddressPools: [
      {
        name: appGwBePoolName
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'appGwBackendHttpSettings'
        properties: {
          port: appGwBackendPort
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
        }
      }
    ]
    httpListeners: [
      {
        name: 'appGwHttpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', appGwName, 'appGwFrontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', appGwName, 'appGwFrontendPort')
          }
          protocol: 'Http'
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'rule1'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', appGwName, 'appGwHttpListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools/', appGwName, appGwBePoolName)
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection/', appGwName, 'appGwBackendHttpSettings')
          }
          priority: 100
        }
      }
    ]
  }
  dependsOn: [
    virtualNetwork

  ]
}

resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2023-03-01' = {
  name: vmScaleSetName
  location: location
  sku: {
    name: vmSku
    tier: 'Standard'
    capacity: instanceCount
  }
  properties: {
    overprovision: true
    singlePlacementGroup: false
    upgradePolicy: {
      mode: 'Automatic'
    }
    virtualMachineProfile: {
      storageProfile: {
        osDisk: {
          caching: 'ReadWrite'
          createOption: 'FromImage'
        }
        imageReference: imageReference[linuxOSVersion]
      }
      osProfile: {
        computerNamePrefix: vmScaleSetName
        adminUsername: adminUsername
        adminPassword: adminPassword
      }
      extensionProfile: {
        extensions: [
          {
            name: 'HealthExtension'
            properties: {
              autoUpgradeMinorVersion: false
              publisher: 'Microsoft.ManagedServices'
              type: 'ApplicationHealthLinux'
              typeHandlerVersion: '1.0'
              settings: {
                protocol: 'https'
                port: 443
                requestPath: '/'
              }
            }
          }
        ]
      }
      securityProfile: ((securityType == 'TrustedLaunch') ? securityProfileJson : null)
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
                      id: resourceId('Microsoft.Network/virtualNetworks/subnets/', virtualNetworkName, subnetName)
                    }
                    applicationGatewayBackendAddressPools: [
                      {
                        id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools/', appGwName, appGwBePoolName)
                      }
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
    userData:loadFileAsBase64('custom.sh')
    }
    automaticRepairsPolicy: {
      enabled: true
      gracePeriod: 'PT10M'
    }
  }
  dependsOn: [
    virtualNetwork
    appGw
  ]
}

resource autoScaleSettings 'microsoft.insights/autoscalesettings@2015-04-01' = {
  name: 'cpuautoscale'
  location: location
  properties: {
    name: 'cpuautoscale'
    targetResourceUri: vmss.id
    enabled: true
    profiles: [
      {
        name: 'Profile1'
        capacity: {
          minimum: '1'
          maximum: '3'
          default: '1'
        }
        rules: [
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: vmss.id
              timeGrain: 'PT1M'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: 50
              statistic: 'Average'
            }
            scaleAction: {
              direction: 'Increase'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT5M'
            }
          }
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: vmss.id
              timeGrain: 'PT1M'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'LessThan'
              threshold: 30
              statistic: 'Average'
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
}
