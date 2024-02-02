@description('Specifies the location for resources.')
param location string = 'westeurope'

param virtualMachines_web_name string = 'webvm'
param virtualNetworks_webvnet_name string = 'webvnet'
param publicIPAddresses_web_ip_name string = 'webtest-ip'
param networkInterfaces_web946_z1_name string = 'web946_z1'
param networkSecurityGroups_web_nsg_name string = 'web-nsg'
param webvirtualNetworkId string = '/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/dev/providers/Microsoft.Network/virtualNetworks/dev_vnet'
param adminUsername string = 'testadmin'
param virtualNetworks_manvnet_externalid string = '/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/manvnet'
// param subnetName string = 'subnet'

@secure()
param adminPassword string = 'Hotnewpassword01'

var vnetId = webvirtualNetworkId
var subnetRef = '${vnetId}/subnets/${'default'}'


resource networkSecurityGroups_web_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2023-06-01' = {
  name: networkSecurityGroups_web_nsg_name
  location: location
  properties: {
    securityRules: [
      {
        name: 'RDP'
        id: 'networkSecurityGroups_web_nsg_name_RDP.id'
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource publicIPAddresses_web_ip_name_resource 'Microsoft.Network/publicIPAddresses@2023-06-01' = {
  name: publicIPAddresses_web_ip_name
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '2'
  ]
  properties: {
    ipAddress: '20.229.120.133'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource virtualNetworks_webvnet_name_resource 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: virtualNetworks_webvnet_name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.20.0/24'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    subnets: [
      {
        name: 'default'
        id: 'virtualNetworks_webnet_name_default.id'
        properties: {
          addressPrefixes: [
            '10.20.20.0/25'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: true
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
//       {
//         name: 'AzureFirewallSubnet'
//         id: 'virtualNetworks_webvnet_name_AzureFirewallSubnet.id'
//         properties: {
//           addressPrefix: '10.20.20.128/26'
//           delegations: []
//           privateEndpointNetworkPolicies: 'Disabled'
//           privateLinkServiceNetworkPolicies: 'Enabled'
//           defaultOutboundAccess: true
//         }
//         type: 'Microsoft.Network/virtualNetworks/subnets'
//       }
    ]
//    virtualNetworkPeerings: [
//      {
//        name: 'webpeering'
//        id: 'virtualNetworks_webnet_name_webpeering.id'
//        properties: {
//          peeringState: 'Connected'
//          peeringSyncLevel: 'FullyInSync'
//          remoteVirtualNetwork: {
//            id: virtualNetworks_manvnet_externalid
//          }
//          allowVirtualNetworkAccess: true
//          allowForwardedTraffic: false
//          allowGatewayTransit: false
//          useRemoteGateways: false
//          doNotVerifyRemoteGateways: false
//          remoteAddressSpace: {
//            addressPrefixes: [
//              '10.10.10.0/24'
//            ]
//          }
//          remoteVirtualNetworkAddressSpace: {
//            addressPrefixes: [
//              '10.10.10.0/24'
//            ]
//          }
//        }
//        type: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
//      }
//    ]
    enableDdosProtection: false
  }
}

resource virtualMachines_web_name_resource 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachines_web_name
  location: location
  zones: [
    '2'
  ]
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: '20_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_web_name}_OsDisk_1_e5acb590116346329274f26facd223c4'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
//          id: disks_web_OsDisk_1_e5acb590116346329274f26facd223c4_externalid
        }
        deleteOption: 'Delete'
        diskSizeGB: 30
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_web_name
      adminUsername: adminUsername
      adminPassword: adminPassword
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
//      requireGuestProvisionSignal: false
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_web946_z1_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource networkSecurityGroups_web_nsg_name_RDP 'Microsoft.Network/networkSecurityGroups/securityRules@2023-06-01' = {
  name: '${networkSecurityGroups_web_nsg_name}/RDP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 300
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_web_nsg_name_resource
  ]
}

// resource virtualNetworks_webvnet_name_AzureFirewallSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
//   name: '${virtualNetworks_webvnet_name}/AzureFirewallSubnet'
//   properties: {
//     addressPrefix: '10.20.20.128/26'
//     delegations: []
//     privateEndpointNetworkPolicies: 'Disabled'
//     privateLinkServiceNetworkPolicies: 'Enabled'
//     defaultOutboundAccess: true
//   }
//   dependsOn: [
//     virtualNetworks_webvnet_name_resource
//   ]
// }

resource virtualNetworks_webvnet_name_default 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  name: '${virtualNetworks_webvnet_name}/default'
  properties: {
    addressPrefixes: [
      '10.20.20.0/25'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: true
  }
  dependsOn: [
    virtualNetworks_webvnet_name_resource
  ]
}

resource virtualNetworks_webvnet_name_webpeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-06-01' = {
  name: '${virtualNetworks_webvnet_name}/webpeering'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_manvnet_externalid
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
//    remoteAddressSpace: {
//      addressPrefixes: [
//        '10.10.10.0/24'
//      ]
//    }
//    remoteVirtualNetworkAddressSpace: {
//      addressPrefixes: [
//        '10.10.10.0/24'
//      ]
//    }
  }
  dependsOn: [
    virtualNetworks_webvnet_name_resource
  ]
}

resource networkInterfaces_web946_z1_name_resource 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: networkInterfaces_web946_z1_name
  location: location
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: subnetRef
        etag: 'W/"ac04e5ac-58b6-48ef-b0bf-80b3f8024291"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.20.20.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_web_ip_name_resource.id
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            id: virtualNetworks_webvnet_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_web_nsg_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}
