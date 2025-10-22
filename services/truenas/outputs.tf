output "ContainerId" {
  description = "truenas 서버 컨테이너 ID"
  value       = proxmox_virtual_environment_vm.truenas.id
}

output "VmId" {
  description = "truenas 서버 VM ID"
  value       = proxmox_virtual_environment_vm.truenas.vm_id
}

output "Hostname" {
  description = "truenas 서버 호스트네임"
  value       = proxmox_virtual_environment_vm.truenas.name
}

output "IpAddress" {
  description = "truenas 서버 IP 주소"
  value       = proxmox_virtual_environment_vm.truenas.ipv4_addresses
}