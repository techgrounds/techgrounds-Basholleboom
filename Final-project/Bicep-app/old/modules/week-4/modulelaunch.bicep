module manmodule './manserver.bicep' = {
  name: 'management-server'
}

module webmodule './webserver.bicep' = {
  name: 'web-server'
}

//module peering './peering1.bicep' = {
//  name: 'peering'
//  dependsOn: [
//    manmodule
//    webmodule
//  ]
//}
