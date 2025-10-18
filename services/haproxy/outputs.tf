output "ContainerId" {
  description = "ha proxy 서버 컨테이너 ID"
  value       = module.haproxy.ContainerId
}

output "VmId" {
  description = "ha proxy 서버 VM ID"
  value       = module.haproxy.VmId
}

output "Hostname" {
  description = "ha proxy 서버 호스트네임"
  value       = module.haproxy.Hostname
}

output "IpAddress" {
  description = "ha proxy 서버 IP 주소"
  value       = module.haproxy.IpAddress
}