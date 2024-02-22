@description('Specifies the location for resources.')
param location string = 'westeurope'

resource keyvault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  location: location
  name: 'keyvault'
  properties: {
    sku:{ 
      family:'A' // zoek familienaam uit
      name: 'standard'
    }
    tenantId:
  }
}
