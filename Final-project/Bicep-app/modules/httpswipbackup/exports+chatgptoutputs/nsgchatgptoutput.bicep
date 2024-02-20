resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  // ... existing properties ...
  properties: {
    securityRules: [
      {
        name: 'allow-ssh'
        properties: {
          priority: 1001
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '22'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: 'VirtualMachineNetworkSecurityGroupId' // Replace with the actual NSG ID of your VM
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'allow-rdp'
        properties: {
          priority: 1002
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '3389'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: 'VirtualMachineNetworkSecurityGroupId' // Replace with the actual NSG ID of your VM
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

// Make sure to replace 'VirtualMachineNetworkSecurityGroupId' with the actual NSG ID of your VM.


resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  // ... existing properties ...
  properties: {
    securityRules: [
      {
        name: 'allow-ssh'
        properties: {
          priority: 1001
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '22'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: 'VirtualMachineScaleSetNetworkSecurityGroupId' // Replace with the actual NSG ID of your VMSS
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'allow-rdp'
        properties: {
          priority: 1002
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '3389'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: 'VirtualMachineScaleSetNetworkSecurityGroupId' // Replace with the actual NSG ID of your VMSS
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

// Make sure to replace 'VirtualMachineScaleSetNetworkSecurityGroupId' with the actual NSG ID of your VMSS.
