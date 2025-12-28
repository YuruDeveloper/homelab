resource "proxmox_virtual_environment_vm" "docker" {
  name      = "docker"
  node_name = var.CommonConfig.ProxmoxNode

  vm_id = var.VmId

  bios    = "ovmf"
  machine = "q35"

  scsi_hardware = "virtio-scsi-pci"

  boot_order = ["scsi0"]

  cpu {
    cores = 1
  }

  memory {
    dedicated = 2048
  }

  efi_disk {
    datastore_id = var.CommonConfig.DatastoreId
    file_format  = "raw"
    type         = "4m"
  }

  disk {
    datastore_id = var.CommonConfig.DatastoreId
    size         = 16
    interface    = "scsi0"
  }

  network_device {
    bridge  = "vmbr1"
    vlan_id = 100
  }

  network_device {
    bridge  = "vmbr1"
    vlan_id = 300
  }

  cdrom {
    file_id = var.AlpineVirtIsoId
  }
}