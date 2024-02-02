param virtualNetworks_manvnet_name string = 'manvnet'
param virtualNetworks_webvnet_name string = 'webvnet'
param virtualNetworks_webvnet_externalid string = '/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/webserver/providers/Microsoft.Network/virtualNetworks/webvnet'
param virtualNetworks_manvnet_externalid string = '/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/manserver/providers/Microsoft.Network/virtualNetworks/manvnet'

resource virtualNetworks_manvnet_name_manpeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-06-01' = {
  name: '${virtualNetworks_manvnet_name}/manpeering'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_webvnet_externalid
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
}

resource virtualNetworks_webvnet_name_webpeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-06-01' = {
  name: '${virtualNetworks_webvnet_name}/webpeering'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_manvnet_externalid
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
}
