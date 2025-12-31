resource "null_resource" "SshSetup" {
  triggers = {
    container_id = var.ContainerId
  }

  provisioner "local-exec" {
    command = <<-EOF
      ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${var.VmId} -- apk add --no-cache openssh python3"
      ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${var.VmId} -- rc-update add sshd"
      ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${var.VmId} -- rc-service sshd start"
      ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${var.VmId} -- sh -c \"sed -i 's/^#*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && if ! grep -q '^PermitRootLogin' /etc/ssh/sshd_config; then echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config; fi\""
      ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${var.VmId} -- sh -c \"sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config && if ! grep -q '^PasswordAuthentication' /etc/ssh/sshd_config; then echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config; fi\""
      ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${var.VmId} -- sh -c \"sed -i 's/^#*PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config && if ! grep -q '^PubkeyAuthentication' /etc/ssh/sshd_config; then echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config; fi\""
      ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${var.VmId} -- rc-service sshd restart"
    EOF
  }
}