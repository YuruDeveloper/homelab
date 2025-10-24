output "ContainerId" {
  description = "Docker 서버 컨테이너 ID"
  value       = module.docker.ContainerId
}

output "VmId" {
  description = "Docker 서버 VM ID"
  value       = module.docker.VmId
}

output "Hostname" {
  description = "Docker 서버 호스트네임"
  value       = module.docker.Hostname
}

output "IpAddress" {
  description = "Docker 서버 IP 주소"
  value       = module.docker.IpAddress
}
