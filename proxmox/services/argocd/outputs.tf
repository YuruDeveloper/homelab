output "ContainerId" {
  description = "argocd 서버 컨테이너 ID"
  value       = proxmox_virtual_environment_vm.argocd.id
}

output "VmId" {
  description = "argocd 서버 VM ID"
  value       = proxmox_virtual_environment_vm.argocd.vm_id
}

output "Hostname" {
  description = "argocd 서버 호스트네임"
  value       = proxmox_virtual_environment_vm.argocd.name
}

output "IpAddress" {
  description = "argocd 서버 IP 주소"
  value       = proxmox_virtual_environment_vm.argocd.ipv4_addresses
}