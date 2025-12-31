resource "null_resource" "SshSetup" {
  triggers = {
    container_id = var.ContainerId
  }

  provisioner "local-exec" {
    command = <<-EOF
      ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${var.ProxmoxUserName}@${var.ProxmoxUrl} "pct exec ${var.VmId} -- ping -c 5 192.168.0.1"
    EOF
  }
}