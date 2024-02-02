module manmodule './vnet1.bicep' = {
  name: 'management-server'
}

module webmodule './vnet2.bicep' = {
  name: 'web-server'
}
