param virtualMachines_manserver_name string = 'manserver'
param disks_manserver_OsDisk_1_9903a9dcaf0e4794ba3909137c7cb49d_externalid string = '/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/manserver_group/providers/Microsoft.Compute/disks/manserver_OsDisk_1_9903a9dcaf0e4794ba3909137c7cb49d'
param networkInterfaces_manserver835_z1_externalid string = '/subscriptions/c4ad36f6-e6a1-405f-afd4-321e43455706/resourceGroups/manserver_group/providers/Microsoft.Network/networkInterfaces/manserver835_z1'

resource virtualMachines_manserver_name_resource 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachines_manserver_name
  location: 'westeurope'
  zones: ['1']
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1ls'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: '20_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_manserver_name}_OsDisk_1_9903a9dcaf0e4794ba3909137c7cb49d'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: disks_manserver_OsDisk_1_9903a9dcaf0e4794ba3909137c7cb49d_externalid
        }
        deleteOption: 'Delete'
        diskSizeGB: 30
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_manserver_name
      adminUsername: 'Mainadmin'
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/Mainadmin/.ssh/authorized_keys'
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+Oe2QMdox2Z01rSmtTZ3xM2nEJnKZux96Ji/G0/5f6BY3KQZYunyq6YDKXyabOTnzfEfKTmS3PBPQFwRukhdVlNSEAYpH16cuVCs0JIog2Uqs2iM07eJNHOXwnHrl8YI+Hnw68MiSt1l4zYhzkBQa9gb3mu2bCaXdic9i/qyIJz8tcfRAU4L4YJvze5OZRAeYPumOpXHAHiHj6zqjWr+08kxB2d2JSX5TGm6e75hYnFb3B/y+W1wZJl2x6gFvanVwh5IUnah4mOMtMJOZ9UG8RexfJ+UsStGTSxF362jU42ObXwkQoryfx6npZRvGGwK4ShMzsSS3HCOIpUyPlWyOU0Fh1ol91jjK0ZA6qcbClRhKs8LQM4/CrBj20inHZCJr4VOot7+wmVeFiJgTqi2AbGebb2zp1ASTmM+UnQvG0ccqNhDrQy9AvmFRmYPQdULXk5DzwOxJ9GwduXvmuDY2doPLlCMZ9k/g8LJGJ4WXnIDlgiutqrGfu4IJTKreLXU= generated-by-azure'
            }
          ]
        }
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_manserver835_z1_externalid
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}
