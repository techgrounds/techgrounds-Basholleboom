module manmodule '../week-3/manfullgenfixed.bicep' = {
  name: 'management-server'
}

module webmodule '../week-3/serverfullgenlinuxfixed.bicep' = {
  name: 'web-server'
}
