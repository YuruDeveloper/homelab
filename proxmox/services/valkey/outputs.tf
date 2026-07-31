output "ContainerId" {
  description = "valkey 서버 컨테이너 ID"
  value       = module.valkey.ContainerId
}

output "VmId" {
  description = "valkey 서버 VM ID"
  value       = module.valkey.VmId
}

output "Hostname" {
  description = "valkey 서버 호스트네임"
  value       = module.valkey.Hostname
}

output "IpAddress" {
  description = "valkey 서버 IP 주소"
  value       = module.valkey.IpAddress
}