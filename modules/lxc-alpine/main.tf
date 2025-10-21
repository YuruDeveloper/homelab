resource "proxmox_virtual_environment_container" "LxcContainer" {
  node_name    = var.ProxmoxNode
  vm_id        = var.VmId
  unprivileged = var.Unprivileged
  cpu {
    cores = var.CpuCores
    units = 1
  }

  memory {
    dedicated = var.Memory
    swap      = var.Swap
  }

  network_interface {
    enabled = true
    name    = "eth0"
    vlan_id = var.VlanId
    bridge  = var.NetworkBridge
  }

  dynamic "network_interface" {
    for_each = var.AdditionalNetworkInterfaces
    content {
      enabled = true
      name    = network_interface.value.name
      vlan_id = network_interface.value.vlan_id
      bridge  = network_interface.value.bridge
    }
  }

  dynamic "features" {
    for_each = var.EnableNesting || var.EnableKeyctl ? [1] : []
    content {
      nesting = var.EnableNesting
      keyctl  = var.EnableKeyctl
    }
  }

  disk {
    datastore_id = var.DatastoreId
    size         = var.DiskSize
  }

  operating_system {
    template_file_id = var.TemplateFileId
    type             = "alpine"
  }

  initialization {
    hostname = var.Hostname
    ip_config {
      ipv4 {
        address = var.IpAddress
        gateway = var.Gateway
      }
    }
    dns {
      servers = var.Dns
    }
    user_account {
      password = var.RootPassword
      keys     = [var.PublicKey]
    }
  }
}

module "SshSetup" {
  source = "../lxc-ssh-setup"

  depends_on = [proxmox_virtual_environment_container.LxcContainer]

  ContainerId      = proxmox_virtual_environment_container.LxcContainer.id
  VmId             = proxmox_virtual_environment_container.LxcContainer.vm_id
  ProxmoxUrl       = var.ProxmoxUrl
  ProxmoxUserName  = var.ProxmoxUserName
}