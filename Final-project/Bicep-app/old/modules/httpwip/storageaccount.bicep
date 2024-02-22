@description('Location for all resources.')
param location string = resourceGroup().location

param virtualMachines_test_name string = 'test'
param sshPublicKeys_test_key_name string = 'test_key'
param publicIPAddresses_test_ip_name string = 'test-ip'
param virtualNetworks_test_vnet_name string = 'test-vnet'
param networkInterfaces_test422_z1_name string = 'test422_z1'
param networkSecurityGroups_test_nsg_name string = 'test-nsg'
param privateEndpoints_storageendpoint_name string = 'storageendpoint'
param storageAccounts_storage123112334_name string = 'storage123112334'
param privateDnsZones_privatelink_blob_core_windows_net_name string = 'privatelink.blob.core.windows.net'

param webvirtualNetworkId string = '/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/minideploy/providers/Microsoft.Storage/storageAccounts/'

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
      id: 'virtualNetworks_test_vnet_name_resource.id'
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
        id: '${privateEndpoints_storageendpoint_name}/privateLinkServiceConnections/${privateEndpoints_storageendpoint_name}_6a30a8ab-142b-4ffa-87e0-9ce823bf0028'
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
      id: 'virtualNetworks_test_vnet_name_default.id'
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
