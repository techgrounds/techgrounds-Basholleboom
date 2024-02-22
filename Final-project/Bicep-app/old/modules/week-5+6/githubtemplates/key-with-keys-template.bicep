param vaults_keyvaultun2o46ajx4zxq_name string = 'keyvaultun2o46ajx4zxq'

resource vaults_keyvaultun2o46ajx4zxq_name_resource 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: vaults_keyvaultun2o46ajx4zxq_name
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
          secrets: [
            'list'
          ]
        }
      }
    ]
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    vaultUri: 'https://${vaults_keyvaultun2o46ajx4zxq_name}.vault.azure.net/'
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Enabled'
  }
}

resource vaults_keyvaultun2o46ajx4zxq_name_mankey 'Microsoft.KeyVault/vaults/keys@2023-07-01' = {
  parent: vaults_keyvaultun2o46ajx4zxq_name_resource
  name: 'mankey'
  location: 'westeurope'
  properties: {
    attributes: {
      enabled: true
      exportable: false
    }
  }
}

resource vaults_keyvaultun2o46ajx4zxq_name_webkey 'Microsoft.KeyVault/vaults/keys@2023-07-01' = {
  parent: vaults_keyvaultun2o46ajx4zxq_name_resource
  name: 'webkey'
  location: 'westeurope'
  properties: {
    attributes: {
      enabled: true
      exportable: false
    }
  }
}

resource vaults_keyvaultun2o46ajx4zxq_name_secretun2o46ajx4zxq 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: vaults_keyvaultun2o46ajx4zxq_name_resource
  name: 'secretun2o46ajx4zxq'
  location: 'westeurope'
  properties: {
    attributes: {
      enabled: true
    }
  }
}
