param location string = resourceGroup().location
resource NetworkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2023-06-01' = {
  name: 'manNSG'
  location: location
  properties:{
    flushConnection: true
    securityRules: [
      {
        id: 'string'
        name: 'string'
        properties: {
          access: 'string'
          description: 'string'
          destinationAddressPrefix: 'string'
          destinationAddressPrefixes: [
            'string'
          ]
          destinationApplicationSecurityGroups: [
            {
              id: 'string'
              location: 'string'
              properties: {}
              tags: {}
            }
          ]
          destinationPortRange: 'string'
          destinationPortRanges: [
            'string'
          ]
          direction: 'string'
          priority: int
          protocol: 'string'
          sourceAddressPrefix: 'string'
          sourceAddressPrefixes: [
            'string'
          ]
          sourceApplicationSecurityGroups: [
            {
              id: 'string'
              location: 'string'
              properties: {}
              tags: {}
            }
          ]
          sourcePortRange: 'string'
          sourcePortRanges: [
            'string'
          ]
        }
        type: 'string'
      }
    ]
  }
}
