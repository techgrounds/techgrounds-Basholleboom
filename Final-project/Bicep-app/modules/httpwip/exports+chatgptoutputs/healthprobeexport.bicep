@description('Size of VMs in the VM Scale Set.')
param vmSku string = 'Standard_D2s_v3'
param imagePublisher string = 'Canonical'
param imageOffer string = 'UbuntuServer'
param imageSku string = '18.04-LTS'
param imageOSVersion string = 'latest'

@description(
  'String used as a base for naming resources. Must be 3-61 characters in length and globally unique across Azure. A hash is prepended to this string for some resources, and resource-specific information is appended.'
)
@maxLength(61)
param vmssName string

@description('Number of VM instances (100 or less).')
@minValue(2)
@maxValue(100)
param instanceCount int = 2

@description('Admin username on all VMs.')
param adminUsername string

@description('Admin password on all VMs.')
@secure()
param adminPassword string

@description('Local http port on VM at which health extension to probe')
param healthProbePort int = 80

@description('Protocol used by health extension to probe app health')
param healthProbeProtocol string = 'http'

@description('Location for the VM scale set')
param location string = resourceGroup().location

@description(
  'The base URI where artifacts required by this template are located including a trailing \'/\''
)
param _artifactsLocation string = deployment().properties.templateLink.uri

@description(
  'The sasToken required to access _artifactsLocation.  When the template is deployed using the accompanying scripts, a sasToken will be automatically generated. Use the defaultValue if the staging location is not secured.'
)
@secure()
param _artifactsLocationSasToken string = ''

var addressPrefix = '10.0.0.0/16'
var subnetName = 'Subnet'
var subnetPrefix = '10.0.0.0/24'
var namingInfix = toLower(
  substring(concat(vmssName, uniqueString(resourceGroup().id)), 0, 9)
)
var virtualNetworkName = '${namingInfix}vnet'
var lbName = '${namingInfix}lb'
var bepoolName = '${lbName}bepool'
var fepoolName = '${lbName}fepool'
var feIpConfigName = '${fepoolName}IpConfig'
var probeName = '${lbName}probe'
var bepoolID = resourceId(
  'Microsoft.Network/loadBalancers/backendAddressPools/',
  lbName,
  bepoolName
)
var feIpConfigId = resourceId(
  'Microsoft.Network/loadBalancers/frontendIPConfigurations/',
  lbName,
  feIpConfigName
)
var platformImageReference = {
  publisher: imagePublisher
  offer: imageOffer
  sku: imageSku
  version: imageOSVersion
}
var imageReference = platformImageReference

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-12-01' = {
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

resource lb 'Microsoft.Network/loadBalancers@2019-12-01' = {
  name: lbName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: feIpConfigName
        properties: {
          subnet: {
            id: resourceId(
              'Microsoft.Network/virtualNetworks/subnets',
              virtualNetworkName,
              subnetName
            )
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: bepoolName
      }
    ]
    loadBalancingRules: [
      {
        name: 'ProbeRule'
        properties: {
          loadDistribution: 'Default'
          frontendIPConfiguration: {
            id: feIpConfigId
          }
          backendAddressPool: {
            id: bepoolID
          }
          protocol: 'Tcp'
          frontendPort: 80
          backendPort: 80
          enableFloatingIP: false
          idleTimeoutInMinutes: 5
          probe: {
            id: resourceId(
              'Microsoft.Network/loadBalancers/probes/',
              lbName,
              probeName
            )
          }
        }
      }
    ]
    probes: [
      {
        name: probeName
        properties: {
          protocol: healthProbeProtocol
          port: healthProbePort
          requestPath: '/'
          intervalInSeconds: 5
          numberOfProbes: 2
        }
      }
    ]
  }
  dependsOn: [virtualNetwork]
}

resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2019-03-01' = {
  name: vmssName
  location: location
  tags: {
    vmsstag: 'automaticrepairs'
  }
  sku: {
    name: vmSku
    tier: 'Standard'
    capacity: instanceCount
  }
  properties: {
    upgradePolicy: {
      mode: 'Manual'
    }
    automaticRepairsPolicy: {
      enabled: true
      gracePeriod: 'PT30M'
    }
    virtualMachineProfile: {
      storageProfile: {
        imageReference: imageReference
      }
      osProfile: {
        computerNamePrefix: 'vmss'
        adminUsername: adminUsername
        adminPassword: adminPassword
      }
      extensionProfile: {
        extensions: [
          {
            name: 'CustomScriptToInstallApache'
            properties: {
              publisher: 'Microsoft.Azure.Extensions'
              type: 'CustomScript'
              typeHandlerVersion: '2.0'
              autoUpgradeMinorVersion: true
              settings: {
                fileUris: [
                  uri(
                    _artifactsLocation,
                    'install_apache.sh${_artifactsLocationSasToken}'
                  )
                ]
                commandToExecute: 'sh install_apache.sh'
              }
            }
          }
        ]
      }
      networkProfile: {
        healthProbe: {
          id: resourceId(
            'Microsoft.Network/loadBalancers/probes/',
            lbName,
            probeName
          )
        }
        networkInterfaceConfigurations: [
          {
            name: 'nic1'
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: 'ip1'
                  properties: {
                    subnet: {
                      id: resourceId(
                        'Microsoft.Network/virtualNetworks/subnets',
                        virtualNetworkName,
                        subnetName
                      )
                    }
                    loadBalancerBackendAddressPools: [
                      {
                        id: bepoolID
                      }
                    ]
                    publicIPAddressConfiguration: {
                      name: 'pub1'
                      properties: {
                        idleTimeoutInMinutes: 15
                      }
                    }
                  }
                }
              ]
            }
          }
        ]
      }
    }
  }
  dependsOn: [lb, virtualNetwork]
}
