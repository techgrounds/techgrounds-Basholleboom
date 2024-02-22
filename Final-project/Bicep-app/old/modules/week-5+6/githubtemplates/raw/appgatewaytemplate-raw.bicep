@description('Username for the Virtual Machine.')
@minLength(1)
param adminUsername string

@description('Password for the Virtual Machine.')
@secure()
param adminPassword string

@description(
  'The Windows version for the VM. This will pick a fully patched image of this given Windows version. Allowed values: 2012-R2-Datacenter, 2016-Datacenter.'
)
@allowed(['2012-R2-Datacenter', '2016-Datacenter'])
param windowsOSVersion string = '2016-Datacenter'

@description(
  'The virtual machine size. Allowed values: Standard_A1, Standard_A2, Standard_A3.'
)
param virtualMachineSize string = 'Standard_D2_v3'

@description('Application Gateway size')
@allowed(['WAF_Medium', 'WAF_Large'])
param applicationGatewaySize string = 'WAF_Medium'

@description('Number of instances')
param capacity int = 2

@description('WAF Mode')
@allowed(['Detection', 'Prevention'])
param wafMode string = 'Prevention'

@description(
  'Base-64 encoded form of the .pfx file. This is the cert terminating on the Application Gateway.'
)
param frontendCertData string

@description('Password for .pfx certificate')
@secure()
param frontendCertPassword string

@description(
  'Base-64 encoded form of the .pfx file. This is the cert installed on the web servers.'
)
param backendCertData string

@description('Password for .pfx certificate')
@secure()
param backendCertPassword string

@description(
  'Base-64 encoded form of the .cer file. This is the public key for the cert on the web servers.'
)
param backendPublicKeyData string

@description('DNS name of the backend cert')
param backendCertDnsName string

@description(
  'The base URI where artifacts required by this template are located. For example, if stored on a public GitHub repo, you\'d use the following URI: https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/201-vmss-windows-webapp-dsc-autoscale.'
)
param _artifactsLocation string = deployment().properties.templateLink.uri

@description(
  'The sasToken required to access _artifactsLocation.  If your artifacts are stored on a public repo or public storage account you can leave this blank.'
)
@secure()
param _artifactsLocationSasToken string = ''

@description('Location for all resources.')
param location string = resourceGroup().location

var imagePublisher = 'MicrosoftWindowsServer'
var imageOffer = 'WindowsServer'
var vm1NicName = 'vm1Nic'
var vm2NicName = 'vm2Nic'
var addressPrefix = '10.0.0.0/16'
var webSubnetName = 'WebSubnet'
var webSubnetPrefix = '10.0.0.0/24'
var appGatewaySubnetName = 'AppGatewaySubnet'
var appGatewaySubnetPrefix = '10.0.1.0/24'
var vm1PublicIPAddressName = 'vm1PublicIP'
var vm1PublicIPAddressType = 'Dynamic'
var vm2PublicIPAddressName = 'vm2PublicIP'
var vm2PublicIPAddressType = 'Dynamic'
var vm1IpAddress = '10.0.0.4'
var vm2IpAddress = '10.0.0.5'
var vm1Name = 'iisvm1'
var vm2Name = 'iisvm2'
var vmSize = virtualMachineSize
var virtualNetworkName = 'MyVNet'
var webSubnetRef = resourceId(
  'Microsoft.Network/virtualNetworks/subnets',
  virtualNetworkName,
  webSubnetName
)
var webAvailabilitySetName = 'IISAvailabilitySet'
var webNsgName = 'WebNSG'
var appGwNsgName = 'AppGwNSG'
var applicationGatewayName = 'ApplicationGateway'
var appGwPublicIpName = 'ApplicationGatewayPublicIp'
var appGatewaySubnetRef = resourceId(
  'Microsoft.Network/virtualNetworks/subnets',
  virtualNetworkName,
  appGatewaySubnetName
)
var appGwPublicIPRef = appGwPublicIp.id
var wafEnabled = true
var wafMode_var = wafMode
var wafRuleSetType = 'OWASP'
var wafRuleSetVersion = '3.0'
var dscZipFullPath = uri(
  _artifactsLocation,
  'DSC/iisInstall.ps1.zip${_artifactsLocationSasToken}'
)
var webConfigFullPath = uri(
  _artifactsLocation,
  'artifacts/web.config${_artifactsLocationSasToken}'
)
var vm1DefaultHtmFullPath = uri(
  _artifactsLocation,
  'artifacts/vm1.default.htm${_artifactsLocationSasToken}'
)
var vm2DefaultHtmFullPath = uri(
  _artifactsLocation,
  'artifacts/vm2.default.htm${_artifactsLocationSasToken}'
)

resource webAvailabilitySet 'Microsoft.Compute/availabilitySets@2020-12-01' = {
  sku: {
    name: 'Aligned'
  }
  name: webAvailabilitySetName
  location: location
  properties: {
    platformUpdateDomainCount: 5
    platformFaultDomainCount: 2
    virtualMachines: [
      {
        id: vm1.id
      }
      {
        id: vm2.id
      }
    ]
  }
}

resource vm1PublicIPAddress 'Microsoft.Network/publicIPAddresses@2016-03-30' = {
  name: vm1PublicIPAddressName
  location: location
  properties: {
    publicIPAllocationMethod: vm1PublicIPAddressType
  }
}

resource vm2PublicIPAddress 'Microsoft.Network/publicIPAddresses@2016-03-30' = {
  name: vm2PublicIPAddressName
  location: location
  properties: {
    publicIPAllocationMethod: vm2PublicIPAddressType
  }
}

resource appGwPublicIp 'Microsoft.Network/publicIPAddresses@2017-03-01' = {
  name: appGwPublicIpName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource webNsg 'Microsoft.Network/networkSecurityGroups@2016-03-30' = {
  name: webNsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow80'
        properties: {
          description: 'Allow 80 from local VNet'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
      {
        name: 'Allow443'
        properties: {
          description: 'Allow 443 from local VNet'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 101
          direction: 'Inbound'
        }
      }
      {
        name: 'AllowRDP'
        properties: {
          description: 'Allow RDP from everywhere'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 102
          direction: 'Inbound'
        }
      }
    ]
  }
}

resource appGwNsg 'Microsoft.Network/networkSecurityGroups@2016-03-30' = {
  name: appGwNsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow80'
        properties: {
          description: 'Allow 80 from Internet'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: 'Internet'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
      {
        name: 'Allow443'
        properties: {
          description: 'Allow 443 from Internet'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: 'Internet'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 102
          direction: 'Inbound'
        }
      }
      {
        name: 'AllowAppGwProbes'
        properties: {
          description: 'Allow ports for App Gw probes'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '65503-65534 '
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 103
          direction: 'Inbound'
        }
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
        name: webSubnetName
        properties: {
          addressPrefix: webSubnetPrefix
          networkSecurityGroup: {
            id: webNsg.id
          }
        }
      }
      {
        name: appGatewaySubnetName
        properties: {
          addressPrefix: appGatewaySubnetPrefix
          networkSecurityGroup: {
            id: appGwNsg.id
          }
        }
      }
    ]
  }
}

resource vm1Nic 'Microsoft.Network/networkInterfaces@2016-03-30' = {
  name: vm1NicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfigVm1'
        properties: {
          privateIPAddress: vm1IpAddress
          privateIPAllocationMethod: 'Static'
          publicIPAddress: {
            id: vm1PublicIPAddress.id
          }
          subnet: {
            id: webSubnetRef
          }
        }
      }
    ]
  }
  dependsOn: [virtualNetwork]
}

resource vm2Nic 'Microsoft.Network/networkInterfaces@2016-03-30' = {
  name: vm2NicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfigVm2'
        properties: {
          privateIPAddress: vm2IpAddress
          privateIPAllocationMethod: 'Static'
          publicIPAddress: {
            id: vm2PublicIPAddress.id
          }
          subnet: {
            id: webSubnetRef
          }
        }
      }
    ]
  }
  dependsOn: [virtualNetwork]
}

resource vm1 'Microsoft.Compute/virtualMachines@2016-04-30-preview' = {
  name: vm1Name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vm1Name
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: imagePublisher
        offer: imageOffer
        sku: windowsOSVersion
        version: 'latest'
      }
      osDisk: {
        name: vm1Name
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: vm1Nic.id
        }
      ]
    }
  }
}

resource vm1Name_Microsoft_Powershell_DSC 'Microsoft.Compute/virtualMachines/extensions@2016-04-30-preview' = {
  parent: vm1
  name: 'Microsoft.Powershell.DSC'
  location: location
  properties: {
    publisher: 'Microsoft.Powershell'
    type: 'DSC'
    typeHandlerVersion: '2.9'
    autoUpgradeMinorVersion: true
    forceUpdateTag: '1.0'
    settings: {
      configuration: {
        url: dscZipFullPath
        script: 'iisInstall.ps1'
        function: 'InstallIIS'
      }
      configurationArguments: {
        nodeName: vm1Name
        vmNumber: 'vm1'
        backendCert: backendCertData
        backendCertPw: backendCertPassword
        backendCertDnsName: backendCertDnsName
        webConfigPath: webConfigFullPath
        defaultHtmPath: vm1DefaultHtmFullPath
      }
    }
  }
}

resource vm2 'Microsoft.Compute/virtualMachines@2016-04-30-preview' = {
  name: vm2Name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vm2Name
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: imagePublisher
        offer: imageOffer
        sku: windowsOSVersion
        version: 'latest'
      }
      osDisk: {
        name: vm2Name
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: vm2Nic.id
        }
      ]
    }
  }
}

resource vm2Name_Microsoft_Powershell_DSC 'Microsoft.Compute/virtualMachines/extensions@2016-04-30-preview' = {
  parent: vm2
  name: 'Microsoft.Powershell.DSC'
  location: location
  properties: {
    publisher: 'Microsoft.Powershell'
    type: 'DSC'
    typeHandlerVersion: '2.9'
    autoUpgradeMinorVersion: true
    forceUpdateTag: '1.0'
    settings: {
      configuration: {
        url: dscZipFullPath
        script: 'iisInstall.ps1'
        function: 'InstallIIS'
      }
      configurationArguments: {
        nodeName: vm2Name
        vmNumber: 'vm2'
        backendCert: backendCertData
        backendCertPw: backendCertPassword
        backendCertDnsName: backendCertDnsName
        webConfigPath: webConfigFullPath
        defaultHtmPath: vm2DefaultHtmFullPath
      }
    }
  }
}

resource applicationGateway 'Microsoft.Network/applicationGateways@2017-06-01' = {
  name: applicationGatewayName
  location: location
  properties: {
    sku: {
      name: applicationGatewaySize
      tier: 'WAF'
      capacity: capacity
    }
    sslCertificates: [
      {
        name: 'appGatewayFrontEndSslCert'
        properties: {
          data: frontendCertData
          password: frontendCertPassword
        }
      }
    ]
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: appGatewaySubnetRef
          }
        }
      }
    ]
    authenticationCertificates: [
      {
        properties: {
          data: backendPublicKeyData
        }
        name: 'appGatewayBackendCert'
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGatewayFrontendIP'
        properties: {
          publicIPAddress: {
            id: appGwPublicIPRef
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'appGatewayFrontendPort80'
        properties: {
          port: 80
        }
      }
      {
        name: 'appGatewayFrontendPort443'
        properties: {
          port: 443
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'appGatewayBackendPool'
        properties: {
          backendAddresses: [
            {
              ipAddress: vm1IpAddress
            }
            {
              ipAddress: vm2IpAddress
            }
          ]
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'appGatewayBackendHttpSettings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
        }
      }
      {
        name: 'appGatewayBackendHttpsSettings'
        properties: {
          port: 443
          protocol: 'Https'
          cookieBasedAffinity: 'Disabled'
          authenticationCertificates: [
            {
              id: resourceId(
                'Microsoft.Network/applicationGateways/authenticationCertificates',
                applicationGatewayName,
                'appGatewayBackendCert'
              )
            }
          ]
        }
      }
    ]
    httpListeners: [
      {
        name: 'appGatewayHttpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/frontendIPConfigurations',
              applicationGatewayName,
              'appGatewayFrontendIP'
            )
          }
          frontendPort: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/frontendPorts',
              applicationGatewayName,
              'appGatewayFrontendPort80'
            )
          }
          protocol: 'Http'
        }
      }
      {
        name: 'appGatewayHttpsListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/frontendIPConfigurations',
              applicationGatewayName,
              'appGatewayFrontendIP'
            )
          }
          frontendPort: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/frontendPorts',
              applicationGatewayName,
              'appGatewayFrontendPort443'
            )
          }
          protocol: 'Https'
          sslCertificate: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/sslCertificates',
              applicationGatewayName,
              'appGatewayFrontEndSslCert'
            )
          }
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'HTTPRule'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/httpListeners',
              applicationGatewayName,
              'appGatewayHttpListener'
            )
          }
          backendAddressPool: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/backendAddressPools',
              applicationGatewayName,
              'appGatewayBackendPool'
            )
          }
          backendHttpSettings: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/backendHttpSettingsCollection',
              applicationGatewayName,
              'appGatewayBackendHttpSettings'
            )
          }
        }
      }
      {
        name: 'HTTPSRule'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/httpListeners',
              applicationGatewayName,
              'appGatewayHttpsListener'
            )
          }
          backendAddressPool: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/backendAddressPools',
              applicationGatewayName,
              'appGatewayBackendPool'
            )
          }
          backendHttpSettings: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/backendHttpSettingsCollection',
              applicationGatewayName,
              'appGatewayBackendHttpsSettings'
            )
          }
        }
      }
    ]
    webApplicationFirewallConfiguration: {
      enabled: wafEnabled
      firewallMode: wafMode_var
      ruleSetType: wafRuleSetType
      ruleSetVersion: wafRuleSetVersion
    }
  }
  dependsOn: [virtualNetwork]
}
