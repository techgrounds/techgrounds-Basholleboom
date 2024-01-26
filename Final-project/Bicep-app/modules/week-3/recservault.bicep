@description('Specifies the location for resources.')
param location string = 'westeurope'

param vaults_recservaulttg_name string = 'recservaulttg'
param vaultcertificate_name string = 'recservaulttg_certificate'
param vault_extinfo_name string = 'vault_extended_information'
resource vaults_recservaulttg_name_resource 'Microsoft.RecoveryServices/vaults@2023-06-01' = {
  name: vaults_recservaulttg_name
  location: location
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {
    securitySettings: {
      immutabilitySettings: {
        state: 'Disabled'
      }
      softDeleteSettings: {
        softDeleteRetentionPeriodInDays: 14
        softDeleteState: 'Enabled'
      }
      multiUserAuthorization: 'Disabled'
    }
    redundancySettings: {}
    publicNetworkAccess: 'Enabled'
    restoreSettings: {
      crossSubscriptionRestoreSettings: {
        crossSubscriptionRestoreState: 'Enabled'
      }
    }
  }
}

resource vaults_recservaulttg_name_DefaultPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-06-01' = {
  parent: vaults_recservaulttg_name_resource
  name: 'DefaultPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2024-01-26T19:00:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2024-01-26T19:00:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_recservaulttg_name_EnhancedPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-06-01' = {
  parent: vaults_recservaulttg_name_resource
  name: 'EnhancedPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    policyType: 'V2'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicyV2'
      scheduleRunFrequency: 'Hourly'
      hourlySchedule: {
        interval: 4
        scheduleWindowStartTime: '2024-01-26T08:00:00Z'
        scheduleWindowDuration: 12
      }
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2024-01-26T08:00:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_recservaulttg_name_HourlyLogBackup 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-06-01' = {
  parent: vaults_recservaulttg_name_resource
  name: 'HourlyLogBackup'
  properties: {
    backupManagementType: 'AzureWorkload'
    workLoadType: 'SQLDataBase'
    settings: {
      timeZone: 'UTC'
      issqlcompression: false
      isCompression: false
    }
    subProtectionPolicy: [
      {
        policyType: 'Full'
        schedulePolicy: {
          schedulePolicyType: 'SimpleSchedulePolicy'
          scheduleRunFrequency: 'Daily'
          scheduleRunTimes: [
            '2024-01-26T19:00:00Z'
          ]
          scheduleWeeklyFrequency: 0
        }
        retentionPolicy: {
          retentionPolicyType: 'LongTermRetentionPolicy'
          dailySchedule: {
            retentionTimes: [
              '2024-01-26T19:00:00Z'
            ]
            retentionDuration: {
              count: 30
              durationType: 'Days'
            }
          }
        }
      }
      {
        policyType: 'Log'
        schedulePolicy: {
          schedulePolicyType: 'LogSchedulePolicy'
          scheduleFrequencyInMins: 60
        }
        retentionPolicy: {
          retentionPolicyType: 'SimpleRetentionPolicy'
          retentionDuration: {
            count: 30
            durationType: 'Days'
          }
        }
      }
    ]
    protectedItemsCount: 0
  }
}

resource vaults_recservaulttg_name_defaultAlertSetting 'Microsoft.RecoveryServices/vaults/replicationAlertSettings@2023-06-01' = {
  parent: vaults_recservaulttg_name_resource
  name: 'defaultAlertSetting'
  properties: {
    sendToOwners: 'DoNotSend'
    customEmailAddresses: []
  }
}

resource vaults_recservaulttg_name_default 'Microsoft.RecoveryServices/vaults/replicationVaultSettings@2023-06-01' = {
  parent: vaults_recservaulttg_name_resource
  name: 'default'
  properties: {}
}
resource vaultcertificate 'Microsoft.RecoveryServices/vaults/certificates@2023-06-01' = {
  name: vaultcertificate_name
//  parent: resourceSymbolicName
  properties: {
    authType: 'string'
    certificate: any()
  }
}
resource vault_extinfo 'Microsoft.RecoveryServices/vaults/extendedInformation@2023-06-01' = {
  name: vault_extinfo_name
//  parent: resourceSymbolicName
//  etag: 'string'
  properties: {
    algorithm: 'string'
    encryptionKey: 'string'
    encryptionKeyThumbprint: 'string'
    integrityKey: 'string'
  }
}
