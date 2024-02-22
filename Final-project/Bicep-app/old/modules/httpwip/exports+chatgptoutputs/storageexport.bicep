param virtualMachines_test_name string = 'test'
param sshPublicKeys_test_key_name string = 'test_key'
param publicIPAddresses_test_ip_name string = 'test-ip'
param virtualNetworks_test_vnet_name string = 'test-vnet'
param networkInterfaces_test422_z1_name string = 'test422_z1'
param networkSecurityGroups_test_nsg_name string = 'test-nsg'
param privateEndpoints_storageendpoint_name string = 'storageendpoint'
param storageAccounts_storage123112334_name string = 'storage123112334'
param privateDnsZones_privatelink_blob_core_windows_net_name string = 'privatelink.blob.core.windows.net'

resource sshPublicKeys_test_key_name_resource 'Microsoft.Compute/sshPublicKeys@2023-03-01' = {
  name: sshPublicKeys_test_key_name
  location: 'westeurope'
  properties: {
    publicKey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDKQhPW+xnEqDSGo1OqrSxHaAFUyuHBuSKJf9YTMK7pyvn1jihQWQChfykRTtYwgU4JKehnaAPWx/zlRNKYIB37Q4MeSXkan4wjLOR/Ggv39kFSVQRoCfQmNZA3lGy3JJUAUk2Dt/CRJLDGr02IouVUarfeI0d7Ib9HOlziOuEfcbB5BaEiCFzydFkcGrHix93kaxkd4sgy0+f37lTCWHNbVA67Y7BWCZ9RoaZ9ivzrU/TmzUu5EbsH2EY4GXE2o+ugx7hQFlSoCW84B9lgpJfFhWmiPcxExcRqnEy9Y2zJe7iWm61Df02jA6iWFDS8vNXQ/lQu4sfw6EdVj5N1Y37U2dHj5jajEq8FC9EWox/FioRAIrglH3B30N9mlGwdNF3456a2o0tgIp8wlr3cd+OPN2FFr9P4J5nfCV4MXFDy0vjbWjRm5KQVqjBOU2ROhOgy5CfwVncm5hi8sWII2t09b5uuEY7jNZv4t8es5tELcn0140OB8L5zUCwHSeqo5VU= generated-by-azure'
  }
}

resource networkSecurityGroups_test_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2023-06-01' = {
  name: networkSecurityGroups_test_nsg_name
  location: 'westeurope'
  properties: {
    securityRules: [
      {
        name: 'SSH'
        id: networkSecurityGroups_test_nsg_name_SSH.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_resource 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: privateDnsZones_privatelink_blob_core_windows_net_name
  location: 'global'
  properties: {
    maxNumberOfRecordSets: 25000
    maxNumberOfVirtualNetworkLinks: 1000
    maxNumberOfVirtualNetworkLinksWithRegistration: 100
    numberOfRecordSets: 2
    numberOfVirtualNetworkLinks: 1
    numberOfVirtualNetworkLinksWithRegistration: 0
    provisioningState: 'Succeeded'
  }
}

resource publicIPAddresses_test_ip_name_resource 'Microsoft.Network/publicIPAddresses@2023-06-01' = {
  name: publicIPAddresses_test_ip_name
  location: 'westeurope'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: ['1']
  properties: {
    ipAddress: '4.231.11.141'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
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
          addressPrefix: '10.0.0.0/24'
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

resource storageAccounts_storage123112334_name_resource 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccounts_storage123112334_name
  location: location
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Disabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource virtualMachines_test_name_resource 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachines_test_name
  location: 'westeurope'
  zones: ['1']
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1ls'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: '20_04-lts-gen2'
        version: 'la${virtualMachines_test_name}'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_test_name}_disk1_8c539f185e954cebb8e2457309494064'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_test_name}_disk1_8c539f185e954cebb8e2457309494064'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 30
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_test_name
      adminUsername: 'azureuser'
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/azureuser/.ssh/authorized_keys'
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDKQhPW+xnEqDSGo1OqrSxHaAFUyuHBuSKJf9YTMK7pyvn1jihQWQChfykRTtYwgU4JKehnaAPWx/zlRNKYIB37Q4MeSXkan4wjLOR/Ggv39kFSVQRoCfQmNZA3lGy3JJUAUk2Dt/CRJLDGr02IouVUarfeI0d7Ib9HOlziOuEfcbB5BaEiCFzydFkcGrHix93kaxkd4sgy0+f37lTCWHNbVA67Y7BWCZ9RoaZ9ivzrU/TmzUu5EbsH2EY4GXE2o+ugx7hQFlSoCW84B9lgpJfFhWmiPcxExcRqnEy9Y2zJe7iWm61Df02jA6iWFDS8vNXQ/lQu4sfw6EdVj5N1Y37U2dHj5jajEq8FC9EWox/FioRAIrglH3B30N9mlGwdNF3456a2o0tgIp8wlr3cd+OPN2FFr9P4J5nfCV4MXFDy0vjbWjRm5KQVqjBOU2ROhOgy5CfwVncm5hi8sWII2t09b5uuEY7jNZv4t8es5tELcn0140OB8L5zUCwHSeqo5VU= generated-by-azure'
            }
          ]
        }
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
          id: networkInterfaces_test422_z1_name_resource.id
          properties: {
            deleteOption: 'Detach'
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

resource networkSecurityGroups_test_nsg_name_SSH 'Microsoft.Network/networkSecurityGroups/securityRules@2023-06-01' = {
  name: '${networkSecurityGroups_test_nsg_name}/SSH'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 300
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [networkSecurityGroups_test_nsg_name_resource]
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_storage123112334 'Microsoft.Network/privateDnsZones/A@2018-09-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: 'storage123112334'
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: '10.0.0.5'
      }
    ]
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_blob_core_windows_net_name 'Microsoft.Network/privateDnsZones/SOA@2018-09-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource virtualNetworks_test_vnet_name_default 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  name: '${virtualNetworks_test_vnet_name}/default'
  properties: {
    addressPrefix: '10.0.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [virtualNetworks_test_vnet_name_resource]
}

resource storageAccounts_storage123112334_name_default 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccounts_storage123112334_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    changeFeed: {
      enabled: false
    }
    restorePolicy: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
    isVersioningEnabled: false
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_storage123112334_name_default 'Microsoft.Storage/storageAccounts/fileServices@2023-01-01' = {
  parent: storageAccounts_storage123112334_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource storageAccounts_storage123112334_name_storageAccounts_storage123112334_name_3048e260_7948_4229_aa17_b71df25a8e14 'Microsoft.Storage/storageAccounts/privateEndpointConnections@2023-01-01' = {
  parent: storageAccounts_storage123112334_name_resource
  name: '${storageAccounts_storage123112334_name}.3048e260-7948-4229-aa17-b71df25a8e14'
  properties: {
    provisioningState: 'Succeeded'
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Auto-Approved'
      actionRequired: 'None'
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_storage123112334_name_default 'Microsoft.Storage/storageAccounts/queueServices@2023-01-01' = {
  parent: storageAccounts_storage123112334_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_storage123112334_name_default 'Microsoft.Storage/storageAccounts/tableServices@2023-01-01' = {
  parent: storageAccounts_storage123112334_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_i2dcvofzmrukk 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: 'i2dcvofzmrukk'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworks_test_vnet_name_resource.id
    }
  }
}

resource privateEndpoints_storageendpoint_name_resource 'Microsoft.Network/privateEndpoints@2023-06-01' = {
  name: privateEndpoints_storageendpoint_name
  location: 'westeurope'
  properties: {
    privateLinkServiceConnections: [
      {
        name: '${privateEndpoints_storageendpoint_name}_6a30a8ab-142b-4ffa-87e0-9ce823bf0028'
        id: '${privateEndpoints_storageendpoint_name_resource.id}/privateLinkServiceConnections/${privateEndpoints_storageendpoint_name}_6a30a8ab-142b-4ffa-87e0-9ce823bf0028'
        properties: {
          privateLinkServiceId: storageAccounts_storage123112334_name_resource.id
          groupIds: ['blob']
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    manualPrivateLinkServiceConnections: []
    subnet: {
      id: virtualNetworks_test_vnet_name_default.id
    }
    ipConfigurations: []
    customDnsConfigs: [
      {
        fqdn: 'storage123112334.blob.core.windows.net'
        ipAddresses: ['10.0.0.5']
      }
    ]
  }
}

resource storageAccounts_storage123112334_name_default_scriptcontainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: storageAccounts_storage123112334_name_default
  name: 'scriptcontainer'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [storageAccounts_storage123112334_name_resource]
}

resource networkInterfaces_test422_z1_name_resource 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: networkInterfaces_test422_z1_name
  location: 'westeurope'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_test422_z1_name_resource.id}/ipConfigurations/ipconfig1'
        etag: 'W/"8cf764e9-ee02-4add-898f-78962eea39a8"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_test_ip_name_resource.id
            properties: {
              deleteOption: 'Detach'
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
      id: networkSecurityGroups_test_nsg_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}
