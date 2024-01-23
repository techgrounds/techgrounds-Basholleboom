@description('Specifies the location for resources.')
param location string = 'westeurope'
param adminusername string = 'testadmn1'

resource adminVM 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: 'adminVM'
  location: location
  properties:{ 
    hardwareProfile:{ 
      vmSize: 'Standard_B1s'
    }
    osProfile: {
      adminUsername: adminusername
      adminPassword: 'Testpassword01'
//      secrets: [
//        {
//          sourceVault: {
//            id: 'string'
//          }
//          vaultCertificates: [
//            {
//              certificateStore: 'string'
//              certificateUrl: 'string'
//            }
//          ]
//        }
//      ]
    }
    securityProfile: {
      encryptionAtHost: false
    }
    storageProfile:{
      osDisk: {
        osType: 'Windows'
        createOption:'Empty'
      }            
    }
    networkProfile: {
      networkApiVersion: '2020-11-01'
      networkInterfaceConfigurations: [
        {
          name: 'testnwinterfaceconfig'
          properties: {
            deleteOption: 'Delete'
            ipConfigurations: [
              {
                name: 'testipconfig'
                properties: {
                  applicationGatewayBackendAddressPools: [
                    {
                      id: 'string'
                    }
                  ]
                  applicationSecurityGroups: [
                    {
                      id: 'string'
                    }
                  ]
                }
              }
            ]
          }
        }
      ]
    }
  }
}
