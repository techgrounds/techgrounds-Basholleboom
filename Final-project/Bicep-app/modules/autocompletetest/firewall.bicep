@description('Specifies the location for resources.')
param location string = 'westeurope'

resource firewall 'Microsoft.Network/azureFirewalls@2023-06-01' ={
  name: 'firewall'
  location: location
}
// zoek firewall later verder uit, ook policies
