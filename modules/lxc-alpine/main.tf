resource "proxmox_virtual_environment_file" "AlpineTemplate" {
  content_type = "vztmpl"
  datastore_id = var.DatastoreId
  node_name    = var.ProxmoxNode

  source_file {
    path = "http://download.proxmox.com/images/system/alpine-${var.AlpineVersion}-default_${var.AlpineTemplateDate}_amd64.tar.xz"
  }
}

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

  disk {
    datastore_id = var.DatastoreId
    size         = var.DiskSize
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_file.AlpineTemplate.id
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
    user_account {
      password = var.RootPassword
      keys     = [var.PublicKey]
    }
  }
}

resource "null_resource" "SshSetup" {
  depends_on = [proxmox_virtual_environment_container.LxcContainer]

  triggers = {
    container_id = proxmox_virtual_environment_container.LxcContainer.id
  }

  provisioner "local-exec" {
    command = <<-EOF
      ssh ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${proxmox_virtual_environment_container.LxcContainer.vm_id} -- apk add --no-cache openssh python3"
      ssh ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${proxmox_virtual_environment_container.LxcContainer.vm_id} -- rc-update add sshd"
      ssh ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${proxmox_virtual_environment_container.LxcContainer.vm_id} -- rc-service sshd start"
      ssh ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${proxmox_virtual_environment_container.LxcContainer.vm_id} -- sed -i '\$a PermitRootLogin yes' /etc/ssh/sshd_config"
      ssh ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${proxmox_virtual_environment_container.LxcContainer.vm_id} -- sed -i '\$a PasswordAuthentication no' /etc/ssh/sshd_config"
      ssh ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${proxmox_virtual_environment_container.LxcContainer.vm_id} -- sed -i '\$a PubkeyAuthentication yes' /etc/ssh/sshd_config"
      ssh ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${proxmox_virtual_environment_container.LxcContainer.vm_id} -- rc-service sshd restart"
    EOF
  }
}