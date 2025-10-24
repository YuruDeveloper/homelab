output "ContainerId" {
  description = "gitea 서버 컨테이너 ID"
  value       = module.gitea.ContainerId
}

output "VmId" {
  description = "gitea 서버 VM ID"
  value       = module.gitea.VmId
}

output "Hostname" {
  description = "gitea 서버 호스트네임"
  value       = module.gitea.Hostname
}

output "IpAddress" {
  description = "gitea 서버 IP 주소"
  value       = module.gitea.IpAddress
}