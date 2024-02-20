@description('Specifies the name of the key vault.')
param keyVaultName string = 'keyvault${uniqueString(resourceGroup().id)}'

@description('Specifies the Azure location where the key vault should be created.')
param location string = resourceGroup().location

@description('Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault.')
param enabledForDeployment bool = false

@description('Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys.')
param enabledForDiskEncryption bool = false

@description('Specifies whether Azure Resource Manager is permitted to retrieve secrets from the key vault.')
param enabledForTemplateDeployment bool = false

@description('Specifies the Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. Get it by using Get-AzSubscription cmdlet.')
param tenantId string = subscription().tenantId

@description('Specifies the object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies. Get it by using Get-AzADUser or Get-AzADServicePrincipal cmdlets.')
param objectId string = '9f264c06-3eac-41ba-a66b-d504b888fb9c'

@description('Specifies the permissions to keys in the vault. Valid values are: all, encrypt, decrypt, wrapKey, unwrapKey, sign, verify, get, list, create, update, import, delete, backup, restore, recover, and purge.')
param keysPermissions array = [
  'Get'
  'List'
  'Update'
  'Create'
  'Import'
  'Delete'
  'Recover'
  'Backup'
  'Restore'
  'GetRotationPolicy'
  'SetRotationPolicy'
  'Rotate'
]

param certificatePermissions array = [
  'all'
  'backup'
  'create'
  'delete'
  'deleteissuers'
  'get'
  'getissuers'
  'import'
  'list'
  'listissuers'
  'managecontacts'
  'manageissuers'
  'purge'
  'recover'
  'restore'
  'setissuers'
  'update'
]


@description('Specifies the permissions to secrets in the vault. Valid values are: all, get, list, set, delete, backup, restore, recover, and purge.')
param secretsPermissions array = [
  'list'
]

@description('Specifies whether the key vault is a standard vault or a premium vault.')
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

@description('Specifies the name of the secret that you want to create.')
param secretName string = 'secret${uniqueString(resourceGroup().id)}'

@description('Specifies the value of the secret that you want to create.')
@secure()
param secretValue string = ''

//param keyvaultid string = '/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/resourceGroup().id)/keyvaultName}'

resource kv 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    tenantId: tenantId
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    accessPolicies: [
      {
        objectId: objectId
        tenantId: tenantId
        permissions: {
          keys: keysPermissions
          secrets: secretsPermissions
          certificates: certificatePermissions
        }
      }
    ]
    sku: {
      name: skuName
      family: 'A'
    }
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
}

resource secret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  parent: kv
  name: secretName
  properties: {
    value: secretValue
  }
}

//resource vaults_keyvault4l4se3mgwihha_name_webserverhttps 'Microsoft.KeyVault/vaults/keys@2023-07-01' = {
//  parent: kv
//  name: 'webserverhttps'
//  location: location
//  properties: {
//    attributes: {
//      enabled: true
//      nbf: 1708223207
//      exp: 1739846207
//    }
//    kty:'RSA'
//  }
//}

//resource Microsoft_KeyVault_vaults_secrets_vaults_keyvault4l4se3mgwihha_name_webserverhttps 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
//  parent: kv
//  name: 'webserverhttps'
//  location: location
//  properties: {
//    value:secretValue
//    contentType: 'application/x-pkcs12'
//    attributes: {
//      enabled: true
//      nbf: 1708223207
//      exp: 1739846207
//    }
//  }
//}

//resource certificate 'Microsoft.Web/certificates@2023-01-01' = {
//  name: 'httpsscertificate'
//  location: location
//  properties:{
//    keyVaultId: keyvaultid
//    keyVaultSecretName:'secretName${uniqueString(resourceGroup().id)}'
//    domainValidationMethod: 'self'
//  }
//}

resource  certificate  'Microsoft.KeyVault/vaults/certificates@2021-06-01-preview' = {
  parent: kv
  name: 'my-certificate'
  properties: {
      certificatePolicy: {
      issuerParameters: {
      name: 'Unknown'
      }
  keyProperties: {
      keyType: 'RSA'
      keySize: 2048
      reuseKey: false
      }
  secretProperties: {
      contentType: 'application/x-pkcs12'
      }
      x509CertificateProperties: {
          subject: 'CN=my-certificate'
          validityInMonths: 12
          }
      }
  }
  managedBy: keyVaultName
}

resource mankey 'Microsoft.KeyVault/vaults/keys@2023-07-01' = {
  parent: kv
  name: 'mankey'
  location: location
  properties: {
    attributes: {
      enabled: true
      exportable: false
    }
    kty: 'RSA'
  }
}

resource webkey 'Microsoft.KeyVault/vaults/keys@2023-07-01' = {
  parent: kv
  name: 'webkey'
  location: location
  properties: {
    attributes: {
      enabled: true
      exportable: false
    }
    kty: 'RSA'
  }
}
