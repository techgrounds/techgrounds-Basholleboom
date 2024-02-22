@description('Set the local VNet name')
param manvnet string 

@description('Set the remote VNet name')
param webvnet string

@description('Sets the remote VNet Resource group')
param ManVirtualNetworkResourceGroupName string
param WebVirtualNetworkResourceGroupName string

resource manvnet_peering_to_webvnet 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-09-01' = {
  name: '${manvnet}/peering-to-webvnet'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: true
    useRemoteGateways: true
    remoteVirtualNetwork: {
      id: resourceId(WebVirtualNetworkResourceGroupName, 'Microsoft.Network/virtualNetworks', webvnet)
    }
  }
}

resource webvnet_peering_to_manvnet 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-09-01' = {
  name: '${webvnet}/peering-to-manvnet'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: true
    remoteVirtualNetwork: {
      id: resourceId(ManVirtualNetworkResourceGroupName, 'Microsoft.Network/virtualNetworks', manvnet)
    }
  }
}
