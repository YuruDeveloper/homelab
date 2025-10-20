resource "null_resource" "SshSetup" {
  triggers = {
    container_id = var.ContainerId
  }

  provisioner "local-exec" {
    command = <<-EOF
      ssh ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${var.VmId} -- apk add --no-cache openssh python3"
      ssh ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${var.VmId} -- rc-update add sshd"
      ssh ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${var.VmId} -- rc-service sshd start"
      ssh ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${var.VmId} -- sed -i '\$a PermitRootLogin yes' /etc/ssh/sshd_config"
      ssh ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${var.VmId} -- sed -i '\$a PasswordAuthentication no' /etc/ssh/sshd_config"
      ssh ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${var.VmId} -- sed -i '\$a PubkeyAuthentication yes' /etc/ssh/sshd_config"
      ssh ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${var.VmId} -- rc-service sshd restart"
    EOF
  }
}