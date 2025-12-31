output "ContainerId" {
  description = "mongodb 서버 컨테이너 ID"
  value       = module.mongodb.ContainerId
}

output "VmId" {
  description = "mongodb 서버 VM ID"
  value       = module.mongodb.VmId
}

output "Hostname" {
  description = "mongodb 서버 호스트네임"
  value       = module.mongodb.Hostname
}

output "IpAddress" {
  description = "mongodb 서버 IP 주소"
  value       = module.mongodb.IpAddress
}