// maak een resource group NOOT: misschien niet handig, controleer later
targetScope = 'subscription'

param resourceGroupName string = 'resourceGroup'
param resourceGrouplocation string = 'westeurope'

resource ResourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01'={
  name: resourceGroupName
  location: resourceGrouplocation
}
