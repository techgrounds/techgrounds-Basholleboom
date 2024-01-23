// SQL Database
// template
resource symbolicname 'Microsoft.Sql/managedInstances/databases@2022-05-01-preview' = {
  name: 'string'
  location: 'string'
  tags: {
    tagName1: 'tagValue1'
    tagName2: 'tagValue2'
  }
  parent: resourceSymbolicName
  properties: {
    autoCompleteRestore: bool
    catalogCollation: 'string'
    collation: 'string'
    createMode: 'string'
    crossSubscriptionRestorableDroppedDatabaseId: 'string'
    crossSubscriptionSourceDatabaseId: 'string'
    crossSubscriptionTargetManagedInstanceId: 'string'
    lastBackupName: 'string'
    longTermRetentionBackupResourceId: 'string'
    recoverableDatabaseId: 'string'
    restorableDroppedDatabaseId: 'string'
    restorePointInTime: 'string'
    sourceDatabaseId: 'string'
    storageContainerIdentity: 'string'
    storageContainerSasToken: 'string'
    storageContainerUri: 'string'
  }
}
