resource "proxmox_virtual_environment_download_file" "truenas" {
  content_type = "iso"
  datastore_id = "local"
  node_name = var.ProxmoxNode
  url = "https://download.sys.truenas.net/TrueNAS-SCALE-Fangtooth/25.04.2.4/TrueNAS-SCALE-25.04.2.4.iso"
}

resource "proxmox_virtual_environment_vm" "truenas" {
  name = "truenas"
  node_name = var.ProxmoxNode

  vm_id = var.VmId

  bios = "ovmf"
  machine = "q35"

  scsi_hardware = "virtio-scsi-pci"

  boot_order = [ "scsi0" ]

  cpu {
    cores = 2
  }

  memory {
    dedicated = 4096
  }

  efi_disk {
    datastore_id = var.DatastoreId
    file_format = "raw"
    type = "4m"
  }

  disk {
    datastore_id = var.DatastoreId
    size = 16
    interface = "scsi0"
  }

  disk {
    datastore_id = ""
    path_in_datastore =  "/dev/disk/by-id/ata-HS-SSD-WAVE_S__256G_30164514896"
    file_format = "raw"
    interface = "sata0"
  }

  disk {
    datastore_id = ""
    path_in_datastore = "/dev/disk/by-id/ata-HS-SSD-WAVE_S__256G_30170974145"
    file_format = "raw"
    interface = "sata1"
  }

  network_device {
    bridge = "vmbr1"
    vlan_id = 100
  }

  cdrom {
    file_id = proxmox_virtual_environment_download_file.truenas.id
  }
}