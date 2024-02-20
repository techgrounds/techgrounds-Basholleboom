param virtualNetworks_test_vnet_name string = 'test-vnet'
param virtualMachineScaleSets_scaleset_name string = 'scaleset'
param virtualMachines_scaleset_24ffbec8_name string = 'scaleset_24ffbec8'
param virtualMachines_scaleset_bb44b892_name string = 'scaleset_bb44b892'
param networkInterfaces_test_vnet_nic01_970d1e98_name string = 'test-vnet-nic01-970d1e98'
param networkInterfaces_test_vnet_nic01_b801cb03_name string = 'test-vnet-nic01-b801cb03'
param networkSecurityGroups_basicNsgtest_vnet_nic01_name string = 'basicNsgtest-vnet-nic01'
param publicIPAddresses_publicIp_test_vnet_nic01_970d1e98_name string = 'publicIp-test-vnet-nic01-970d1e98'
param publicIPAddresses_publicIp_test_vnet_nic01_b801cb03_name string = 'publicIp-test-vnet-nic01-b801cb03'

resource networkSecurityGroups_basicNsgtest_vnet_nic01_name_resource 'Microsoft.Network/networkSecurityGroups@2023-06-01' = {
  name: networkSecurityGroups_basicNsgtest_vnet_nic01_name
  location: 'westeurope'
  properties: {
    securityRules: []
  }
}

resource publicIPAddresses_publicIp_test_vnet_nic01_970d1e98_name_resource 'Microsoft.Network/publicIPAddresses@2023-06-01' = {
  name: publicIPAddresses_publicIp_test_vnet_nic01_970d1e98_name
  location: 'westeurope'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '172.211.20.155'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 15
    ipTags: []
  }
}

resource publicIPAddresses_publicIp_test_vnet_nic01_b801cb03_name_resource 'Microsoft.Network/publicIPAddresses@2023-06-01' = {
  name: publicIPAddresses_publicIp_test_vnet_nic01_b801cb03_name
  location: 'westeurope'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '20.160.150.230'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 15
    ipTags: []
  }
}

resource virtualNetworks_test_vnet_name_resource 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: virtualNetworks_test_vnet_name
  location: 'westeurope'
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: 'default'
        id: virtualNetworks_test_vnet_name_default.id
        properties: {
          addressPrefix: '10.0.0.0/20'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualMachineScaleSets_scaleset_name_virtualMachineScaleSets_scaleset_name_24ffbec8 'Microsoft.Compute/virtualMachineScaleSets/virtualMachines@2023-03-01' = {
  parent: virtualMachineScaleSets_scaleset_name_resource
  name: '${virtualMachineScaleSets_scaleset_name}_24ffbec8'
  location: 'westeurope'
  zones: [null]
}

resource virtualMachineScaleSets_scaleset_name_virtualMachineScaleSets_scaleset_name_bb44b892 'Microsoft.Compute/virtualMachineScaleSets/virtualMachines@2023-03-01' = {
  parent: virtualMachineScaleSets_scaleset_name_resource
  name: '${virtualMachineScaleSets_scaleset_name}_bb44b892'
  location: 'westeurope'
  zones: [null]
}

resource virtualNetworks_test_vnet_name_default 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  name: '${virtualNetworks_test_vnet_name}/default'
  properties: {
    addressPrefix: '10.0.0.0/20'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [virtualNetworks_test_vnet_name_resource]
}

resource virtualMachines_scaleset_24ffbec8_name_resource 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachines_scaleset_24ffbec8_name
  location: 'westeurope'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1ls'
    }
    virtualMachineScaleSet: {
      id: virtualMachineScaleSets_scaleset_name_resource.id
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: '20_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_scaleset_24ffbec8_name}_OsDisk_1_b834c9377eda40f89cf01a220fd67058'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_scaleset_24ffbec8_name}_OsDisk_1_b834c9377eda40f89cf01a220fd67058'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 30
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: 'scalesetmA9KMA0'
      adminUsername: 'testadmin'
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_test_vnet_nic01_b801cb03_name_resource.id
          properties: {
            primary: true
            deleteOption: 'Delete'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource virtualMachines_scaleset_bb44b892_name_resource 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachines_scaleset_bb44b892_name
  location: 'westeurope'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1ls'
    }
    virtualMachineScaleSet: {
      id: virtualMachineScaleSets_scaleset_name_resource.id
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: '20_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_scaleset_bb44b892_name}_OsDisk_1_ffc77d90608a4c9f8c125b6b8b2751e2'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_scaleset_bb44b892_name}_OsDisk_1_ffc77d90608a4c9f8c125b6b8b2751e2'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 30
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: 'scalesetmJ2JGBY'
      adminUsername: 'testadmin'
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_test_vnet_nic01_970d1e98_name_resource.id
          properties: {
            primary: true
            deleteOption: 'Delete'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource virtualMachineScaleSets_scaleset_name_resource 'Microsoft.Compute/virtualMachineScaleSets@2023-03-01' = {
  name: virtualMachineScaleSets_scaleset_name
  location: 'westeurope'
  sku: {
    name: 'Standard_B1ls'
    tier: 'Standard'
    capacity: 2
  }
  properties: {
    singlePlacementGroup: false
    orchestrationMode: 'Flexible'
    virtualMachineProfile: {
      osProfile: {
        computerNamePrefix: '${virtualMachineScaleSets_scaleset_name}m'
        adminUsername: 'testadmin'
        linuxConfiguration: {
          disablePasswordAuthentication: false
          provisionVMAgent: true
          patchSettings: {
            patchMode: 'ImageDefault'
            assessmentMode: 'ImageDefault'
          }
          enableVMAgentPlatformUpdates: false
        }
        secrets: []
        allowExtensionOperations: true
        requireGuestProvisionSignal: true
      }
      storageProfile: {
        osDisk: {
          osType: 'Linux'
          createOption: 'FromImage'
          caching: 'ReadWrite'
          managedDisk: {
            storageAccountType: 'Premium_LRS'
          }
          deleteOption: 'Delete'
          diskSizeGB: 30
        }
        imageReference: {
          publisher: 'canonical'
          offer: '0001-com-ubuntu-server-focal'
          sku: '20_04-lts-gen2'
          version: 'latest'
        }
        diskControllerType: 'SCSI'
      }
      networkProfile: {
        networkApiVersion: '2020-11-01'
        networkInterfaceConfigurations: [
          {
            name: 'test-vnet-nic01'
            properties: {
              primary: true
              enableAcceleratedNetworking: false
              disableTcpStateTracking: false
              enableIPForwarding: false
              deleteOption: 'Delete'
              ipConfigurations: [
                {
                  name: 'test-vnet-nic01-defaultIpConfiguration'
                  properties: {
                    privateIPAddressVersion: 'IPv4'
                    subnet: {
                      id: virtualNetworks_test_vnet_name_default.id
                    }
                    primary: true
                    publicIPAddressConfiguration: {
                      name: 'publicIp-test-vnet-nic01'
                      properties: {
                        idleTimeoutInMinutes: 15
                        ipTags: []
                        publicIPAddressVersion: 'IPv4'
                      }
                    }
                    applicationSecurityGroups: []
                    loadBalancerBackendAddressPools: []
                    applicationGatewayBackendAddressPools: []
                  }
                }
              ]
              networkSecurityGroup: {
                id: networkSecurityGroups_basicNsgtest_vnet_nic01_name_resource.id
              }
              dnsSettings: {
                dnsServers: []
              }
            }
          }
        ]
      }
      diagnosticsProfile: {
        bootDiagnostics: {
          enabled: true
        }
      }
      extensionProfile: {
        extensions: []
      }
      securityProfile: {
        uefiSettings: {
          secureBootEnabled: true
          vTpmEnabled: true
        }
        securityType: 'TrustedLaunch'
      }
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    platformFaultDomainCount: 1
    constrainedMaximumCapacity: false
  }
}

resource networkInterfaces_test_vnet_nic01_970d1e98_name_resource 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: networkInterfaces_test_vnet_nic01_970d1e98_name
  location: 'westeurope'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'test-vnet-nic01-defaultIpConfiguration'
        id: '${networkInterfaces_test_vnet_nic01_970d1e98_name_resource.id}/ipConfigurations/test-vnet-nic01-defaultIpConfiguration'
        etag: 'W/"86d03f30-8376-4b77-94ed-36e4eb8e1d66"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.0.0.5'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_publicIp_test_vnet_nic01_970d1e98_name_resource.id
            properties: {
              deleteOption: 'Delete'
            }
          }
          subnet: {
            id: virtualNetworks_test_vnet_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_basicNsgtest_vnet_nic01_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource networkInterfaces_test_vnet_nic01_b801cb03_name_resource 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: networkInterfaces_test_vnet_nic01_b801cb03_name
  location: 'westeurope'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'test-vnet-nic01-defaultIpConfiguration'
        id: '${networkInterfaces_test_vnet_nic01_b801cb03_name_resource.id}/ipConfigurations/test-vnet-nic01-defaultIpConfiguration'
        etag: 'W/"8d5ad900-54f2-4a96-8280-3d4d611415fa"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_publicIp_test_vnet_nic01_b801cb03_name_resource.id
            properties: {
              deleteOption: 'Delete'
            }
          }
          subnet: {
            id: virtualNetworks_test_vnet_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_basicNsgtest_vnet_nic01_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}
