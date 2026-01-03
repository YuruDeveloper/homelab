output "ContainerId" {
  description = "redpanda 서버 컨테이너 ID"
  value       = module.redpanda.ContainerId
}

output "VmId" {
  description = "redpanda 서버 VM ID"
  value       = module.redpanda.VmId
}

output "Hostname" {
  description = "redpanda 서버 호스트네임"
  value       = module.redpanda.Hostname
}

output "IpAddress" {
  description = "redpanda 서버 IP 주소"
  value       = module.redpanda.IpAddress
}