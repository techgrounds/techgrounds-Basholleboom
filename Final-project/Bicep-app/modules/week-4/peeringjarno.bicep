resource vnet1ToVnet2Peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-06-01' = {
  name: 'VNet1ToVNet2'
  parent: vnet1
  properties: {
    remoteVirtualNetwork: {
      id: vnet2.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}
resource vnet2ToVnet1Peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-06-01' = {
  name: 'VNet2ToVNet1'
  parent: vnet2
  properties: {
    remoteVirtualNetwork: {
      id: vnet1.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}





