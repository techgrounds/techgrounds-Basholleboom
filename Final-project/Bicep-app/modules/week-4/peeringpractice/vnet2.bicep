@description('Specifies the location for resources.')
param location string = 'westeurope'

param virtualNetworks_webvnet_name string = 'webvnet'
param virtualNetworks_manvnet_externalid string = '/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/manserver/providers/Microsoft.Network/virtualNetworks/manvnet'

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

resource peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
  name: 'virtualNetwork/name'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: true
    useRemoteGateways: true
    remoteVirtualNetwork: {
      id: virtualNetworks_manvnet_externalid
    }
  }
}
