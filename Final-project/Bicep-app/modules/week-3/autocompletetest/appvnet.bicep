@description('Specifies the location for resources.')
param location string = 'westeurope'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: 'appVNet'
  location: location
  properties:{
    addressSpace: {
      addressPrefixes: [
        '10.10.10.0/24'
        '10.20.20.0/24'
      ]
    }
  }
}
