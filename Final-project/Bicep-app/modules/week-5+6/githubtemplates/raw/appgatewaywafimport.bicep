@description(
  'Specifies the location for all resources that is created by this template.'
)
param location string = resourceGroup().location

@description('Specifies the address prefix for the Virtual Network.')
param vNetAddressPrefix string = '10.20.20.0/24'

@description('Specifies the subnet prefix')
param vNetSubnetPrefix string = '10.20.20.0/25'

@description('Specifies the application gateway SKU name.')
@allowed(['WAF_v2'])
param applicationGatewaySize string = 'WAF_v2'

@description('Specifies the number of the application gateway instances.')
@allowed([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
param applicationGatewayCapacity int = 2

@description('IP Address for Backend Server 1')
param backendIpAddress1 string = '10.0.1.10'

@description('IP Address for Backend Server 2')
param backendIpAddress2 string = '10.0.1.11'

@description('WAF Enabled')
param wafEnabled bool = true

@description('WAF Mode')
@allowed(['Detection', 'Prevention'])
param wafMode string = 'Detection'

@description('WAF Rule Set Type')
@allowed(['OWASP'])
param wafRuleSetType string = 'OWASP'

@description('WAF Rule Set Version')
@allowed(['2.2.9', '3.0'])
param wafRuleSetVersion string = '3.0'

var applicationGatewayName = 'applicationGateway1'
var publicIPAddressName = 'publicIp1'
var virtualNetworkName = 'virtualNetwork1'
var subnetName = 'appGatewaySubnet'
var subnetRef = resourceId(
  'Microsoft.Network/virtualNetworks/subnets/',
  virtualNetworkName,
  subnetName
)
var publicIPRef = publicIPAddress.id

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2020-05-01' = {
  name: publicIPAddressName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-05-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [vNetAddressPrefix]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: vNetSubnetPrefix
        }
      }
    ]
  }
}

resource applicationGateway 'Microsoft.Network/applicationGateways@2020-05-01' = {
  name: applicationGatewayName
  location: location
  properties: {
    sku: {
      name: applicationGatewaySize
      tier: 'WAF_v2'
      capacity: applicationGatewayCapacity
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: subnetRef
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGatewayFrontendIP'
        properties: {
          publicIPAddress: {
            id: publicIPRef
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'appGatewayFrontendPort'
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'appGatewayBackendPool'
        properties: {
          backendAddresses: [
            {
              ipAddress: backendIpAddress1
            }
            {
              ipAddress: backendIpAddress2
            }
          ]
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'appGatewayBackendHttpSettings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
        }
      }
    ]
    httpListeners: [
      {
        name: 'appGatewayHttpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/frontendIPConfigurations',
              applicationGatewayName,
              'appGatewayFrontendIP'
            )
          }
          frontendPort: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/frontendPorts',
              applicationGatewayName,
              'appGatewayFrontendPort'
            )
          }
          protocol: 'Http'
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'rule1'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/httpListeners',
              applicationGatewayName,
              'appGatewayHttpListener'
            )
          }
          backendAddressPool: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/backendAddressPools',
              applicationGatewayName,
              'appGatewayBackendPool'
            )
          }
          backendHttpSettings: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/backendHttpSettingsCollection',
              applicationGatewayName,
              'appGatewayBackendHttpSettings'
            )
          }
        }
      }
    ]
    webApplicationFirewallConfiguration: {
      enabled: wafEnabled
      firewallMode: wafMode
      ruleSetType: wafRuleSetType
      ruleSetVersion: wafRuleSetVersion
    }
  }
  dependsOn: [virtualNetwork]
}
