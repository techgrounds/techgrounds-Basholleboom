module manmodule './manserver.bicep' = {
  name: 'management-server'
}

module webmodule './webserver.bicep' = {
  name: 'web-server'
}
