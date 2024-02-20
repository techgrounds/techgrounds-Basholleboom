param applicationGateways_appgw_name string = 'appgw'
param virtualNetworks_appgwvnet_name string = 'appgwvnet'
param publicIPAddresses_gatewayip_name string = 'gatewayip'

resource publicIPAddresses_gatewayip_name_resource 'Microsoft.Network/publicIPAddresses@2023-06-01' = {
  name: publicIPAddresses_gatewayip_name
  location: 'westeurope'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '20.101.53.62'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource virtualNetworks_appgwvnet_name_resource 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: virtualNetworks_appgwvnet_name
  location: 'westeurope'
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: 'default'
        id: 'virtualNetworks_appgwvnet_name_default.id'
        properties: {
          addressPrefix: '10.0.0.0/24'
          applicationGatewayIPConfigurations: [
            {
              id: '${'applicationGateways_appgw_name_resource.id'}/gatewayIPConfigurations/appGatewayIpConfig'
            }
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource applicationGateways_appgw_name_resource 'Microsoft.Network/applicationGateways@2023-06-01' = {
  name: applicationGateways_appgw_name
  location: 'westeurope'
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        id: '${'applicationGateways_appgw_name_resource.id'}/gatewayIPConfigurations/appGatewayIpConfig'
        properties: {
          subnet: {
            id: virtualNetworks_appgwvnet_name_default.id
          }
        }
      }
    ]
    sslCertificates: []
    trustedRootCertificates: []
    trustedClientCertificates: []
    sslProfiles: []
    frontendIPConfigurations: [
      {
        name: 'appGwPublicFrontendIpIPv4'
        id: '${'applicationGateways_appgw_name_resource.id'}/frontendIPConfigurations/appGwPublicFrontendIpIPv4'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_gatewayip_name_resource.id
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'port_80'
        id: '${'applicationGateways_appgw_name_resource.id'}/frontendPorts/port_80'
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'gatewaybackend'
        id: '${'applicationGateways_appgw_name_resource.id'}/backendAddressPools/gatewaybackend'
        properties: {
          backendAddresses: []
        }
      }
    ]
    loadDistributionPolicies: []
    backendHttpSettingsCollection: [
      {
        name: 'backendsettingtest'
        id: '${'applicationGateways_appgw_name_resource.id'}/backendHttpSettingsCollection/backendsettingtest'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          requestTimeout: 20
        }
      }
    ]
    backendSettingsCollection: []
    httpListeners: [
      {
        name: 'risuna'
        id: '${'applicationGateways_appgw_name_resource.id'}/httpListeners/risuna'
        properties: {
          frontendIPConfiguration: {
            id: '${'applicationGateways_appgw_name_resource.id'}/frontendIPConfigurations/appGwPublicFrontendIpIPv4'
          }
          frontendPort: {
            id: '${'applicationGateways_appgw_name_resource.id'}/frontendPorts/port_80'
          }
          protocol: 'Http'
          hostNames: []
          requireServerNameIndication: false
          customErrorConfigurations: []
        }
      }
    ]
    listeners: []
    urlPathMaps: []
    requestRoutingRules: [
      {
        name: 'ruletest'
        id: '${'applicationGateways_appgw_name_resource.id'}/requestRoutingRules/ruletest'
        properties: {
          ruleType: 'Basic'
          priority: 300
          httpListener: {
            id: '${'applicationGateways_appgw_name_resource.id'}/httpListeners/risuna'
          }
          backendAddressPool: {
            id: '${'applicationGateways_appgw_name_resource.id'}/backendAddressPools/gatewaybackend'
          }
          backendHttpSettings: {
            id: '${'applicationGateways_appgw_name_resource.id'}/backendHttpSettingsCollection/backendsettingtest'
          }
        }
      }
    ]
    routingRules: []
    probes: []
    rewriteRuleSets: []
    redirectConfigurations: []
    privateLinkConfigurations: []
    enableHttp2: true
    autoscaleConfiguration: {
      minCapacity: 1
      maxCapacity: 3
    }
  }
}

resource virtualNetworks_appgwvnet_name_default 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  name: '${virtualNetworks_appgwvnet_name}/default'
  properties: {
    addressPrefix: '10.0.0.0/24'
    applicationGatewayIPConfigurations: [
      {
        id: '${'applicationGateways_appgw_name_resource.id'}/gatewayIPConfigurations/appGatewayIpConfig'
      }
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [virtualNetworks_appgwvnet_name_resource]
}
