@description('Size of VMs in the VM Scale Set.')
param vmSku string = 'Standard_A1'

@description(
  'The Ubuntu version for the VM. This will pick a fully patched image of this given Ubuntu version. Allowed values are: 15.10, 14.04.4-LTS.'
)
@allowed(['14.04.4-LTS'])
param ubuntuOSVersion string = '14.04.4-LTS'

@description(
  'String used as a base for naming resources. Must be 3-61 characters in length and globally unique across Azure. A hash is prepended to this string for some resources, and resource-specific information is appended.'
)
@maxLength(61)
param vmssName string

@description('Number of VM instances (100 or less).')
@maxValue(100)
param capacity int

@description('Admin username on all VMs.')
param adminUsername string

@description('The Azure Key vault where SSL certificates are stored')
param vaultName string

@description('Resource Group of the key vault')
param vaultResourceGroup string

@description('full Key Vault Id to the secret that stores the SSL cert')
param httpssecretUrlWithVersion string

@description('full Key Vault Id to the secret that stores the CA cert')
param httpssecretCaUrlWithVersion string

@description('the file name of the script configuring the VMs in the scale set')
param scriptFileName string

@description('fingerprint of the SSL cert')
param certThumbPrint string

@description('fingerprint of the CA cert')
param caCertThumbPrint string

@description(
  'The base URI where artifacts required by this template are located. When the template is deployed using the accompanying scripts, a private location in the subscription will be used and this value will be automatically generated.'
)
param _artifactsLocation string = 'https://raw.githubusercontent.com/azure/azure-quickstart-templates/master/quickstarts/microsoft.compute/vmss-ubuntu-web-ssl/configuressl.sh'

@description(
  'The sasToken required to access _artifactsLocation.  When the template is deployed using the accompanying scripts, a sasToken will be automatically generated.'
)
@secure()
param _artifactsLocationSasToken string = ''

@description('Location for all resources.')
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
var addressPrefix = '10.0.0.0/16'
var subnetPrefix = '10.0.0.0/24'
var virtualNetworkName = '${namingInfix_var}vnet'
var subnetName = '${namingInfix_var}subnet'
var lbName = '${namingInfix_var}lb'
var bepoolName = '${lbName}bepool'
var fepoolName = '${lbName}fepool'
var lbID = lb.id
var bepoolID = '${lbID}/backendAddressPools/${bepoolName}'
var feIpConfigName = '${fepoolName}IpConfig'
var feIpConfigId = '${lbID}/frontendIPConfigurations/${feIpConfigName}'
var pipName = '${namingInfix_var}pip'
var nicName = '${namingInfix_var}nic'
var natPoolName = '${lbName}natpool'
var ipConfigName = '${namingInfix_var}ipconfig'
var httpProbeName = 'httpProbe'
var httpsProbeName = 'httpsProbe'
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

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2016-03-30' = {
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

resource pip 'Microsoft.Network/publicIPAddresses@2016-03-30' = {
  name: pipName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    dnsSettings: {
      domainNameLabel: namingInfix_var
    }
  }
}

resource lb 'Microsoft.Network/loadBalancers@2016-03-30' = {
  name: lbName
  location: location
  tags: {
    displayName: 'Load Balancer'
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: feIpConfigName
        properties: {
          publicIPAddress: {
            id: pip.id
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: bepoolName
      }
    ]
    inboundNatPools: [
      {
        name: natPoolName
        properties: {
          frontendIPConfiguration: {
            id: feIpConfigId
          }
          protocol: 'Tcp'
          frontendPortRangeStart: 10022
          frontendPortRangeEnd: 10050
          backendPort: 22
        }
      }
    ]
    loadBalancingRules: [
      {
        name: 'HTTPRule'
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
            id: '${lbID}/probes/${httpProbeName}'
          }
        }
      }
      {
        name: 'HTTPSRule'
        properties: {
          loadDistribution: 'Default'
          frontendIPConfiguration: {
            id: feIpConfigId
          }
          backendAddressPool: {
            id: bepoolID
          }
          protocol: 'Tcp'
          frontendPort: 443
          backendPort: 443
          enableFloatingIP: false
          idleTimeoutInMinutes: 5
          probe: {
            id: '${lb.id}/probes/${httpsProbeName}'
          }
        }
      }
    ]
    probes: [
      {
        name: httpProbeName
        properties: {
          protocol: 'Tcp'
          port: 80
          intervalInSeconds: 5
          numberOfProbes: 2
        }
      }
      {
        name: httpsProbeName
        properties: {
          protocol: 'Tcp'
          port: 443
          intervalInSeconds: 5
          numberOfProbes: 2
        }
      }
    ]
  }
}

resource namingInfix 'Microsoft.Compute/virtualMachineScaleSets@2016-04-30-preview' = {
  name: namingInfix_var
  location: location
  sku: {
    name: vmSku
    tier: 'Standard'
    capacity: capacity
  }
  properties: {
    overProvision: 'true'
    upgradePolicy: {
      mode: 'Manual'
    }
    virtualMachineProfile: {
      storageProfile: {
        osDisk: {
          caching: 'ReadWrite'
          createOption: 'FromImage'
        }
        imageReference: imageReference
      }
      osProfile: {
        computerNamePrefix: namingInfix_var
        adminUsername: adminUsername
        adminPassword: adminPasswordOrKey
        secrets: [
          {
            sourceVault: {
              id: resourceId(
                vaultResourceGroup,
                'Microsoft.KeyVault/vaults',
                vaultName
              )
            }
            vaultCertificates: [
              {
                certificateUrl: httpssecretUrlWithVersion
              }
              {
                certificateUrl: httpssecretCaUrlWithVersion
              }
            ]
          }
        ]
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
                        'Microsoft.Network/virtualNetworks/subnets',
                        virtualNetworkName,
                        subnetName
                      )
                    }
                    loadBalancerBackendAddressPools: [
                      {
                        id: resourceId(
                          'Microsoft.Network/loadBalancers/backendAddressPools',
                          lbName,
                          bepoolName
                        )
                      }
                    ]
                    loadBalancerInboundNatPools: [
                      {
                        id: resourceId(
                          'Microsoft.Network/loadBalancers/inboundNatPools',
                          lbName,
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
      extensionProfile: {
        extensions: [
          {
            name: 'lapextension'
            properties: {
              publisher: 'Microsoft.Azure.Extensions'
              type: 'CustomScript'
              typeHandlerVersion: '2.0'
              autoUpgradeMinorVersion: false
              settings: {
                fileUris: [
                  '${_artifactsLocation}/${scriptFileName}${_artifactsLocationSasToken}'
                ]
              }
              protectedSettings: {
                commandToExecute: 'bash ${scriptFileName} ${certThumbPrint} ${caCertThumbPrint}'
              }
            }
          }
        ]
      }
    }
  }
  dependsOn: [lb, virtualNetwork]
}

output fqdn string = pip.properties.dnsSettings.fqdn
