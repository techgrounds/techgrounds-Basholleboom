@description('Specifies the location for resources.')
param location string = 'westeurope'

module keyvault 'keyvault.bicep' = {
  name: 'keyvault'
  params:{
    location: location
  }
}

module manserver 'manserver.bicep' = {
  name: 'management-server'
  params:{
    location: location
    publicIpName: 'manpublicIP'
    zone: '1'
    adminPassword: 'Hotnewpassword01'
  }
  dependsOn:[keyvault]
}

module webserver 'webserver.bicep' = {
name: 'web-server'
params:{
  adminPassword: 'Hotnewpassword01'
  location:location
}
dependsOn:[keyvault]
}

module peering 'peering.bicep' = {
  name: 'peering'
  params:{
    ManVirtualNetworkResourceGroupName: resourceGroup().name
    WebVirtualNetworkResourceGroupName: resourceGroup().name
    manvnet: 'manvnet'
    webvnet: 'webvnet'
  }
  dependsOn:[manserver, webserver]
}
