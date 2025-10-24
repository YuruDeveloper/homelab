output "ContainerId" {
  description = "nginx 서버 컨테이너 ID"
  value       = module.nginx.ContainerId
}

output "VmId" {
  description = "nginx 서버 VM ID"
  value       = module.nginx.VmId
}

output "Hostname" {
  description = "nginx 서버 호스트네임"
  value       = module.nginx.Hostname
}

output "IpAddress" {
  description = "nginx 서버 IP 주소"
  value       = module.nginx.IpAddress
}