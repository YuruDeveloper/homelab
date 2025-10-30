resource "proxmox_virtual_environment_network_linux_bridge" "vmbr1" {
  node_name = var.proxmox_node
  name = "vmbr1"
  vlan_aware = true
  ports = []
  gateway = "192.168.0.1"
  address = "192.168.0.2/24"
}

resource "proxmox_virtual_environment_network_linux_bridge" "vmbr2" {
  node_name = var.proxmox_node
  name = "vmbr2"
  ports = ["enx00e04c360027"]
}

resource "proxmox_virtual_environment_vm" "opnsense" {
    node_name = var.proxmox_node
    vm_id = 100
    name = "opnsense"

    bios = "ovmf"
    machine = "q35"

    scsi_hardware = "virtio-scsi-pci"

    cpu {
      cores = 1
      type = "host"
    }

    memory {
      dedicated = 2048
    }

    boot_order = ["scsi0","ide2"]

    efi_disk {
      datastore_id = "local-lvm"
      file_format = "raw"
      type = "4m"
    }

    disk {
      datastore_id = "local-lvm"
      interface = "scsi0"
      size = 16
      file_format = "raw"
    }

    cdrom {
      file_id = "local:iso/OPNsense-25.7-dvd-amd64.iso"
      interface = "ide2"
    }

    network_device {
      bridge = "vmbr0"
    }

    network_device {
      bridge = "vmbr1"
    }

    network_device {
      bridge = "vmbr2"
    }
}