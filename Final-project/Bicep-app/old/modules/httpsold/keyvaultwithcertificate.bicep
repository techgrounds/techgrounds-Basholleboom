param vaults_keyvault4l4se3mgwihha_name string = 'keyvault4l4se3mgwihha'

resource vaults_keyvault4l4se3mgwihha_name_resource 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: vaults_keyvault4l4se3mgwihha_name
  location: 'westeurope'
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
    accessPolicies: [
      {
        tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
        objectId: '9f264c06-3eac-41ba-a66b-d504b888fb9c'
        permissions: {
          keys: [
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
          secrets: ['list']
          certificates: [
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
        }
      }
    ]
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    vaultUri: 'https://${vaults_keyvault4l4se3mgwihha_name}.vault.azure.net/'
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Enabled'
  }
}

resource vaults_keyvault4l4se3mgwihha_name_mankey 'Microsoft.KeyVault/vaults/keys@2023-07-01' = {
  parent: vaults_keyvault4l4se3mgwihha_name_resource
  name: 'mankey'
  location: 'westeurope'
  properties: {
    attributes: {
      enabled: true
      exportable: false
    }
  }
}

resource vaults_keyvault4l4se3mgwihha_name_webkey 'Microsoft.KeyVault/vaults/keys@2023-07-01' = {
  parent: vaults_keyvault4l4se3mgwihha_name_resource
  name: 'webkey'
  location: 'westeurope'
  properties: {
    attributes: {
      enabled: true
      exportable: false
    }
  }
}

resource vaults_keyvault4l4se3mgwihha_name_webserverhttps 'Microsoft.KeyVault/vaults/keys@2023-07-01' = {
  parent: vaults_keyvault4l4se3mgwihha_name_resource
  name: 'webserverhttps'
  location: 'westeurope'
  properties: {
    attributes: {
      enabled: true
      nbf: 1708223207
      exp: 1739846207
    }
  }
}

resource vaults_keyvault4l4se3mgwihha_name_secret4l4se3mgwihha 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: vaults_keyvault4l4se3mgwihha_name_resource
  name: 'secret4l4se3mgwihha'
  location: 'westeurope'
  properties: {
    attributes: {
      enabled: true
    }
  }
}

resource Microsoft_KeyVault_vaults_secrets_vaults_keyvault4l4se3mgwihha_name_webserverhttps 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: vaults_keyvault4l4se3mgwihha_name_resource
  name: 'webserverhttps'
  location: 'westeurope'
  properties: {
    contentType: 'application/x-pkcs12'
    attributes: {
      enabled: true
      nbf: 1708223207
      exp: 1739846207
    }
  }
}
