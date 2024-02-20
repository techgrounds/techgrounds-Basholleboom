@description('Set the local VNet name')
param manvnet string 

@description('Set the remote VNet name')
param webvnet string

@description('Sets the remote VNet Resource group')
param WebVirtualNetworkResourceGroupName string

resource manvnet_peering_to_webvnet 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-09-01' = {
  name: '${manvnet}/peering-to-webvnet'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: resourceId(WebVirtualNetworkResourceGroupName, 'Microsoft.Network/virtualNetworks', webvnet)
    }
  }
}
