// VNet voor app server
// @minLength(3)
// @maxLength(24)
// param storageAccountName string = 'store${uniqueString(resourceGroup().id)}'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: 'appVNet'
  location: resourceGroup().location
  properties:{
    addressSpace: {
      addressPrefixes: [
        '10.10.10.0/24'
        '10.20.20.0/24'
      ]
    }
  }
}
