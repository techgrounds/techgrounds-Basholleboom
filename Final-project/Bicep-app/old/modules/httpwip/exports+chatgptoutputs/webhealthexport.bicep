param virtualMachineScaleSets_webvmssan_name string = 'webvmssan'
param virtualNetworks_webvnet_externalid string = '/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/healthtest/providers/Microsoft.Network/virtualNetworks/webvnet'
param applicationGateways_webvmssanappGw_externalid string = '/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/healthtest/providers/Microsoft.Network/applicationGateways/webvmssanappGw'
param disks_webvmssan_webvmssan_2_OsDisk_1_2ab0a9cfa85940bb83ee65d0a67820c5_externalid string = '/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/healthtest/providers/Microsoft.Compute/disks/webvmssan_webvmssan_2_OsDisk_1_2ab0a9cfa85940bb83ee65d0a67820c5'

resource virtualMachineScaleSets_webvmssan_name_resource 'Microsoft.Compute/virtualMachineScaleSets@2023-03-01' = {
  name: virtualMachineScaleSets_webvmssan_name
  location: 'westeurope'
  sku: {
    name: 'Standard_D2s_v3'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    singlePlacementGroup: false
    orchestrationMode: 'Uniform'
    upgradePolicy: {
      mode: 'Automatic'
    }
    virtualMachineProfile: {
      osProfile: {
        computerNamePrefix: virtualMachineScaleSets_webvmssan_name
        adminUsername: 'Mainadmin'
        linuxConfiguration: {
          disablePasswordAuthentication: false
          provisionVMAgent: true
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
          diskSizeGB: 30
        }
        imageReference: {
          publisher: 'Canonical'
          offer: '0001-com-ubuntu-server-focal'
          sku: '20_04-lts-gen2'
          version: 'latest'
        }
        diskControllerType: 'SCSI'
      }
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: '${virtualMachineScaleSets_webvmssan_name}nic'
            properties: {
              primary: true
              enableAcceleratedNetworking: false
              disableTcpStateTracking: false
              dnsSettings: {
                dnsServers: []
              }
              enableIPForwarding: false
              ipConfigurations: [
                {
                  name: '${virtualMachineScaleSets_webvmssan_name}ipconfig'
                  properties: {
                    subnet: {
                      id: '${virtualNetworks_webvnet_externalid}/subnets/${virtualMachineScaleSets_webvmssan_name}subnet'
                    }
                    privateIPAddressVersion: 'IPv4'
                    applicationGatewayBackendAddressPools: [
                      {
                        id: '${applicationGateways_webvmssanappGw_externalid}/backendAddressPools/${virtualMachineScaleSets_webvmssan_name}appGwBepool'
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
      securityProfile: {
        uefiSettings: {
          secureBootEnabled: true
          vTpmEnabled: true
        }
        securityType: 'TrustedLaunch'
      }
    }
    overprovision: true
    doNotRunExtensionsOnOverprovisionedVMs: false
    automaticRepairsPolicy: {
      enabled: true
      gracePeriod: 'PT10M'
    }
  }
}

resource virtualMachineScaleSets_webvmssan_name_HealthExtension 'Microsoft.Compute/virtualMachineScaleSets/extensions@2023-03-01' = {
  parent: virtualMachineScaleSets_webvmssan_name_resource
  name: 'HealthExtension'
  properties: {
    provisioningState: 'Updating'
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

resource virtualMachineScaleSets_webvmssan_name_2 'Microsoft.Compute/virtualMachineScaleSets/virtualMachines@2023-03-01' = {
  parent: virtualMachineScaleSets_webvmssan_name_resource
  name: '2'
  location: 'westeurope'
  sku: {
    name: 'Standard_D2s_v3'
    tier: 'Standard'
  }
  properties: {
    networkProfileConfiguration: {
      networkInterfaceConfigurations: [
        {
          name: 'webvmssannic'
          properties: {
            primary: true
            enableAcceleratedNetworking: false
            disableTcpStateTracking: false
            dnsSettings: {
              dnsServers: []
            }
            enableIPForwarding: false
            ipConfigurations: [
              {
                name: 'webvmssanipconfig'
                properties: {
                  subnet: {
                    id: '${virtualNetworks_webvnet_externalid}/subnets/webvmssansubnet'
                  }
                  privateIPAddressVersion: 'IPv4'
                  applicationGatewayBackendAddressPools: [
                    {
                      id: '${applicationGateways_webvmssanappGw_externalid}/backendAddressPools/webvmssanappGwBepool'
                    }
                  ]
                }
              }
            ]
          }
        }
      ]
    }
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: '20_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: 'webvmssan_webvmssan_2_OsDisk_1_2ab0a9cfa85940bb83ee65d0a67820c5'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: disks_webvmssan_webvmssan_2_OsDisk_1_2ab0a9cfa85940bb83ee65d0a67820c5_externalid
        }
        diskSizeGB: 30
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: 'webvmssan000002'
      adminUsername: 'Mainadmin'
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
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
          id: '${virtualMachineScaleSets_webvmssan_name_2.id}/networkInterfaces/webvmssannic'
        }
      ]
    }
  }
}

resource virtualMachineScaleSets_webvmssan_name_6 'Microsoft.Compute/virtualMachineScaleSets/virtualMachines@2023-03-01' = {
  parent: virtualMachineScaleSets_webvmssan_name_resource
  name: '6'
  location: 'westeurope'
  sku: {
    name: 'Standard_D2s_v3'
    tier: 'Standard'
  }
  properties: {
    networkProfileConfiguration: {
      networkInterfaceConfigurations: [
        {
          name: 'webvmssannic'
          properties: {
            primary: true
            enableAcceleratedNetworking: false
            disableTcpStateTracking: false
            dnsSettings: {
              dnsServers: []
            }
            enableIPForwarding: false
            ipConfigurations: [
              {
                name: 'webvmssanipconfig'
                properties: {
                  subnet: {
                    id: '${virtualNetworks_webvnet_externalid}/subnets/webvmssansubnet'
                  }
                  privateIPAddressVersion: 'IPv4'
                  applicationGatewayBackendAddressPools: [
                    {
                      id: '${applicationGateways_webvmssanappGw_externalid}/backendAddressPools/webvmssanappGwBepool'
                    }
                  ]
                }
              }
            ]
          }
        }
      ]
    }
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: '20_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        diskSizeGB: 30
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: 'webvmssan000006'
      adminUsername: 'Mainadmin'
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
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
  }
}

resource virtualMachineScaleSets_webvmssan_name_2_HealthExtension 'Microsoft.Compute/virtualMachineScaleSets/virtualMachines/extensions@2023-03-01' = {
  name: '${virtualMachineScaleSets_webvmssan_name}/2/HealthExtension'
  location: 'westeurope'
  properties: {
    autoUpgradeMinorVersion: false
    publisher: 'Microsoft.ManagedServices'
    type: 'ApplicationHealthLinux'
    typeHandlerVersion: '1.0'
    settings: {}
  }
  dependsOn: [
    virtualMachineScaleSets_webvmssan_name_2
    virtualMachineScaleSets_webvmssan_name_resource
  ]
}

resource virtualMachineScaleSets_webvmssan_name_6_HealthExtension 'Microsoft.Compute/virtualMachineScaleSets/virtualMachines/extensions@2023-03-01' = {
  parent: virtualMachineScaleSets_webvmssan_name_6
  name: 'HealthExtension'
  location: 'westeurope'
  properties: {
    autoUpgradeMinorVersion: false
    publisher: 'Microsoft.ManagedServices'
    type: 'ApplicationHealthLinux'
    typeHandlerVersion: '1.0'
    settings: {}
  }
  dependsOn: [virtualMachineScaleSets_webvmssan_name_resource]
}
