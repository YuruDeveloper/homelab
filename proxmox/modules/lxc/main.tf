resource "proxmox_virtual_environment_container" "LxcContainer" {
  node_name    = var.CommonConfig.ProxmoxNode
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
    datastore_id = var.CommonConfig.DatastoreId
    size         = var.DiskSize
  }

  dynamic "mount_point" {
    for_each = var.MountPoints
    content {
      volume    = mount_point.value.volume
      path      = mount_point.value.mount_point
      shared    = true
      replicate = false
    }
  }

  operating_system {
    template_file_id = var.TemplateFileId
    type             = var.OsType
  }

  initialization {
    hostname = var.Hostname
    ip_config {
      ipv4 {
        address = var.IpAddress
        gateway = var.Gateway
      }
    }
    dynamic "dns" {
      for_each = length(var.Dns) > 0 ? [1] : []
      content {
        servers = var.Dns
      }
    }
    user_account {
      password = var.CommonConfig.RootPassword
      keys     = [var.CommonConfig.PublicKey]
    }
  }
}

# Alpine일 때만 SSH Setup 실행
module "SshSetup" {
  count  = var.OsType == "alpine" ? 1 : 0
  source = "../alpine-ssh-setup"

  depends_on = [proxmox_virtual_environment_container.LxcContainer]

  ContainerId     = proxmox_virtual_environment_container.LxcContainer.id
  VmId            = proxmox_virtual_environment_container.LxcContainer.vm_id
  ProxmoxUrl      = var.CommonConfig.ProxmoxUrl
  ProxmoxUserName = var.CommonConfig.ProxmoxUserName
}
