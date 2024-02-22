@description('Specifies the location for resources.')
param location string = 'westeurope'

module manserver 'manserver.bicep' = {
  name: 'management-server'
  params:{
    location: location
    publicIpName: 'manpublicIP'
    zone: '1'
  }
}

module webserver 'webserver.bicep' = {
name: 'web-server'
params:{
  location:location
  zone: '2'
//  virtualNetworkName: 'webpublicIP'
}
}

module peering 'peering.bicep' = {
  name: 'peering'
  params:{
    ManVirtualNetworkResourceGroupName: 'resourceGroup()'
    WebVirtualNetworkResourceGroupName: 'resourceGroup()'
    manvnet: 'manvnet'
    webvnet: 'webvnet'
  }
  dependsOn:[manserver, webserver]
}

//The property "dependsOn" expected a value of type "(module[] | (resource | module) | resource[])[]" but the provided value is of type "module".bicep(BCP036)

//https://learn.microsoft.com/nl-nl/azure/azure-resource-manager/troubleshooting/error-not-found?tabs=bicep
//Content:
//{"status":"Failed","error":{"code":"DeploymentFailed","target":"/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/test2/providers/Microsoft.Resources/deployments/main-240208-1502","message":"At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-deployment-operations for usage details.","details":[{"code":"ResourceDeploymentFailure","target":"/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/test2/providers/Microsoft.Resources/deployments/peering","message":"The resource write operation failed to complete successfully, because it reached terminal provisioning state 'Failed'.","details":[{"code":"DeploymentFailed","target":"/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/test2/providers/Microsoft.Resources/deployments/peering","message":"At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-deployment-operations for usage details.","details":[{"code":"InvalidGlobalResourceReference","message":"Resource /subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/resourceGroup()/providers/Microsoft.Network/virtualNetworks/webvnet referenced by resource /subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/test2/providers/Microsoft.Network/virtualNetworks/manvnet/virtualNetworkPeerings/peering-to-webvnet was not found. Please make sure that the referenced resource exists.","details":[]},{"code":"ResourceNotFound","message":"The Resource 'Microsoft.Network/virtualNetworks/webvnet' under resource group 'test2' was not found. For more details please go to https://aka.ms/ARMResourceNotFoundFix"}]}]}]}}
