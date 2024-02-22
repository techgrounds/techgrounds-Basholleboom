sProfile: {
  computerName: vmName
  adminUsername: adminUsername
  adminPassword: adminPasswordOrKey
  customData: loadFileAsBase64('customdata.sh')
  linuxConfiguration: ((authenticationType == 'password') ? null : linuxConfiguration)
}
customData: loadFileAsBase64('customdata.sh')
