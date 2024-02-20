param keyVaultName string = 'keyvault${uniqueString(resourceGroup().id)}'
param certificateName string = 'cert'
param subjectName string = 'CN=subject'
@description('Specifies the Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. Get it by using Get-AzSubscription cmdlet.')
param tenantId string = subscription().tenantId

@description('Specifies the object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies. Get it by using Get-AzADUser or Get-AzADServicePrincipal cmdlets.')
param objectId string = '9f264c06-3eac-41ba-a66b-d504b888fb9c'

resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: keyVaultName
  location: 'westeurope' // Replace with your desired Azure region
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: [
      {
        objectId: objectId
        tenantId:tenantId
        permissions: {
          keys: ['get', 'list', 'create', 'delete', 'import', 'update', 'backup', 'restore']
          secrets: ['get', 'list', 'set', 'delete', 'backup', 'restore']
          certificates: ['get', 'list', 'create', 'import', 'delete', 'update', 'managecontacts', 'getissuers', 'listissuers', 'setissuers', 'deleteissuers', 'manageissuers', 'recover', 'purge']
        }
      }
    ]
  }
}

resource certificate 'Microsoft.KeyVault/vaults/certificates@2021-06-01-preview' = {
  name: '${keyVault.name}/${certificateName}'
  properties: {
    issuerParameters: {
      name: 'Self'
    }
    x509CertificateProperties: {
      subject: subjectName
      validityInMonths: 12
    }
    keyProperties: {
      keyType: 'RSA'
      keySize: 2048
      reuseKey: false
    }
  }
  dependsOn: [
    keyVault
  ]
}

output keyVaultResourceId string = keyVault.id
output certificateSecretUri string = certificate.properties.secretId
