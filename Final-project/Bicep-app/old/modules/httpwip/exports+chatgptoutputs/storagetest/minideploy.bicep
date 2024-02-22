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

//module storage 'storageaccount.bicep' ={
//  name: 'script-storage'
//  dependsOn:[manserver]
//  params:{
//    location: location
//  }
//}
