param virtualNetworks_manvnet_name string = 'manvnet'
param virtualNetworks_webvnet_name string = 'webvnet'

resource virtualNetworks_manvnet_name_resource 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: virtualNetworks_manvnet_name
  location: 'westeurope'
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
        id: virtualNetworks_manvnet_name_default.id
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
    virtualNetworkPeerings: [
      {
        name: '${virtualNetworks_manvnet_name}test'
        id: virtualNetworks_manvnet_name_virtualNetworks_manvnet_name_test.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_webvnet_name_resource.id
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: false
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.20.20.0/24'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.20.20.0/24'
            ]
          }
        }
        type: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
      }
    ]
    enableDdosProtection: false
  }
}

resource virtualNetworks_webvnet_name_resource 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: virtualNetworks_webvnet_name
  location: 'westeurope'
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
        id: virtualNetworks_webvnet_name_default.id
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
    virtualNetworkPeerings: [
      {
        name: '${virtualNetworks_webvnet_name}test'
        id: virtualNetworks_webvnet_name_virtualNetworks_webvnet_name_test.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_manvnet_name_resource.id
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: false
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.10.10.0/24'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.10.10.0/24'
            ]
          }
        }
        type: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
      }
    ]
    enableDdosProtection: false
  }
}

resource virtualNetworks_manvnet_name_default 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  name: '${virtualNetworks_manvnet_name}/default'
  properties: {
    addressPrefixes: [
      '10.10.10.0/25'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: true
  }
  dependsOn: [
    virtualNetworks_manvnet_name_resource
  ]
}

resource virtualNetworks_webvnet_name_default 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  name: '${virtualNetworks_webvnet_name}/default'
  properties: {
    addressPrefixes: [
      '10.20.20.0/25'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: true
  }
  dependsOn: [
    virtualNetworks_webvnet_name_resource
  ]
}

resource virtualNetworks_manvnet_name_virtualNetworks_manvnet_name_test 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-06-01' = {
  name: '${virtualNetworks_manvnet_name}/${virtualNetworks_manvnet_name}test'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_webvnet_name_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.20.20.0/24'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.20.20.0/24'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_manvnet_name_resource

  ]
}

resource virtualNetworks_webvnet_name_virtualNetworks_webvnet_name_test 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-06-01' = {
  name: '${virtualNetworks_webvnet_name}/${virtualNetworks_webvnet_name}test'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_manvnet_name_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.10.10.0/24'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.10.10.0/24'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_webvnet_name_resource

  ]
}