// storage account, mag niet publiekelijk toegankelijk zijn
param location string = resourceGroup().location
@minLength(3)
@maxLength(24)
@description('Provide a name for the storage account. Use only lower case letters and numbers. The name must be unique across Azure.')
param storageAccountname string = 'store${uniqueString(resourceGroup().id)}'

resource exampleStorage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountname
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
