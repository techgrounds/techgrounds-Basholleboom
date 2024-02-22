param vaults_keyvaulttesttg_name string = 'keyvaulttesttg'

resource vaults_keyvaulttesttg_name_resource 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: vaults_keyvaulttesttg_name
  location: 'westeurope'
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
    accessPolicies: []
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enableRbacAuthorization: true
    vaultUri: 'https://${vaults_keyvaulttesttg_name}.vault.azure.net/'
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Enabled'
  }
}
