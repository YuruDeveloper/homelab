output "ContainerId" {
  description = "LXC 컨테이너 ID"
  value       = proxmox_virtual_environment_container.LxcContainer.id
}

output "VmId" {
  description = "LXC 컨테이너 VM ID"
  value       = proxmox_virtual_environment_container.LxcContainer.vm_id
}

output "Hostname" {
  description = "컨테이너 호스트네임"
  value       = var.Hostname
}

output "IpAddress" {
  description = "컨테이너 IP 주소"
  value       = var.IpAddress
}
