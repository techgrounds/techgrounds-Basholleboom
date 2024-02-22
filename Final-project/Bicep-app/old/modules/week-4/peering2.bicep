param sourceNetworkname string ='manvnet'

param destinationNetworkname string = 'webvnet'

resource sourceNetwork 'Microsoft.Network/virtualNetworks@2023-06-01' existing = {
  name: sourceNetworkname
}

resource destinationNetwork 'Microsoft.Network/virtualNetworks@2022-09-01' existing = {
  name: destinationNetworkname
}

resource sourceToDestinationPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-07-01' = {
  name: '${manvnet}-To-${webvnet}'
  parent: sourceNetwork
  properties: {
    allowForwardedTraffic: true
    allowGatewayTransit: true
    remoteVirtualNetwork: {
      id: destinationNetwork.id
    }
  }
}

resource destinationToSourcePeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-06-01' = {
  name: '${webvnet}-To-${manvnet}'
  parent: destinationNetwork
  properties: {
    allowForwardedTraffic: true
    allowGatewayTransit: true
    remoteVirtualNetwork: {
      id: sourceNetwork.id
    }
  }
}
