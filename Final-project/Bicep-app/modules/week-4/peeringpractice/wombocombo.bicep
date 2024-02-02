@description('Specifies the location for resources.')
param location string = 'westeurope'

param virtualNetworks_manvnet_name string = 'manvnet'
param virtualNetworks_webvnet_externalid string = '/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/webvnet'
param virtualNetworks_webvnet_name string = 'webvnet'
param virtualNetworks_manvnet_externalid string = '/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/manvnet'

resource virtualNetworks_manvnet_name_resource 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: virtualNetworks_manvnet_name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.10.0/24'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    subnets: [
      {
        name: 'default'
        id: 'virtualNetworks_manvnet_name_default.id'
        properties: {
          addressPrefixes: [
            '10.10.10.0/25'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: true
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    enableDdosProtection: false
  }
}

resource peering1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
  name: 'virtualNetworkpeering1'
  parent: virtualNetworks_manvnet_name_resource
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: virtualNetworks_webvnet_externalid
    }
  }
  dependsOn: [
    virtualNetworks_webvnet_name_resource
  ]
}



resource virtualNetworks_webvnet_name_resource 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: virtualNetworks_webvnet_name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.20.0/24'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    subnets: [
      {
        name: 'default'
        id: 'virtualNetworks_webnet_name_default.id'
        properties: {
          addressPrefixes: [
            '10.20.20.0/25'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: true
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    enableDdosProtection: false
  }
}

resource peering2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
  name: 'virtualNetworkpeering2'
  parent: virtualNetworks_webvnet_name_resource
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: virtualNetworks_manvnet_externalid
    }
  }
  dependsOn: [
    virtualNetworks_manvnet_name_resource
  ]
}
