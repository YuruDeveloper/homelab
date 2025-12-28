output "ContainerId" {
  description = "Docker 서버 컨테이너 ID"
  value       = proxmox_virtual_environment_vm.docker.id
}

output "VmId" {
  description = "Docker 서버 VM ID"
  value       = proxmox_virtual_environment_vm.docker.vm_id
}

output "Hostname" {
  description = "Docker 서버 호스트네임"
  value       = proxmox_virtual_environment_vm.docker.name
}

output "IpAddress" {
  description = "Docker 서버 IP 주소"
  value       = proxmox_virtual_environment_vm.docker.ipv4_addresses
}