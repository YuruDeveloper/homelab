output "ContainerId" {
  description = "redis 서버 컨테이너 ID"
  value       = module.redis.ContainerId
}

output "VmId" {
  description = "redis 서버 VM ID"
  value       = module.redis.VmId
}

output "Hostname" {
  description = "redis 서버 호스트네임"
  value       = module.redis.Hostname
}

output "IpAddress" {
  description = "redis 서버 IP 주소"
  value       = module.redis.IpAddress
}