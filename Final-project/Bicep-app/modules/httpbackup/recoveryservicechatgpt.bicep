param storageAccountName string = 'backupstorage'
param recoveryServicesVaultName string = 'webrecoveryservice'
param virtualMachineName string
param virtualMachineResourceGroup string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccountName
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource recoveryServicesVault 'Microsoft.RecoveryServices/vaults@2021-06-01' = {
  name: recoveryServicesVaultName
  location: resourceGroup().location
  properties: {
    sku: {
      family: 'A'
      name: 'RS0'
    }
  }
}

resource backupVault 'Microsoft.RecoveryServices/vaults/backupFabrics/backupProtectionIntent@2021-11-01-preview' = {
  name: '${recoveryServicesVault.name}/default/protectionIntent'
  properties: {
    itemType: 'VM'
    policyId: '/subscriptions/<subscription-id>/resourceGroups/${virtualMachineResourceGroup}/providers/Microsoft.Compute/virtualMachines/${virtualMachineName}/backupPolicies/default'
    sourceResourceId: '/subscriptions/<subscription-id>/resourceGroups/${virtualMachineResourceGroup}/providers/Microsoft.Compute/virtualMachines/${virtualMachineName}'
  }
  identity:{
    type:'SystemAssigned'
  }
  sku:{
    family: 'A'
    name: 'RS0'
  }
}

resource dailyBackupPolicy 'Microsoft.RecoveryServices/vaults/backupFabrics/backupPolicies@2021-11-01-preview' = {
  name: '${recoveryServicesVault.name}/backupPolicies/dailyBackupPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRpRetentionRangeInDays: 7
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunDays: 'Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday'
      scheduleRunTimes: '2024-02-19T12:00:00'
      scheduleWeeklyFrequency: 1
    }
  }
  sku:{
    family: 'A'
    name: 'RS0'
  }
}

//Make sure to replace <subscription-id> with your actual subscription ID. This Bicep template creates a Storage Account, a Recovery Services Vault, a Backup Vault, and a daily backup policy for a virtual machine. The backup policy is configured to run daily and retain backups for 7 days.

//Keep in mind that Bicep templates can be complex, and you may need to adapt this example based on your specific requirements and Azure environment. Always refer to the latest Azure Resource Manager template documentation for the most up-to-date information.
