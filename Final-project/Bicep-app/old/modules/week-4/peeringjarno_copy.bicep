module vnet1 'peeringpractice/vnet1.bicep' ={
  name: 'manvnet'
  
}

module webvnet 'peeringpractice/vnet2.bicep' ={
  name: 'webvnet'
}


resource mantowebPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-06-01' = {
  name: 'mantowebVNet'
  properties: {
    remoteVirtualNetwork: {
      id: webvnet.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}
resource webtomanVnet1Peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-06-01' = {
  name: 'webtoman'
  properties: {
    remoteVirtualNetwork: {
      id: manvnet.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}





