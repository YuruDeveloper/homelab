output "ContainerId" {
  description = "postgresql 서버 컨테이너 ID"
  value       = module.postgresql.ContainerId
}

output "VmId" {
  description = "postgresql 서버 VM ID"
  value       = module.postgresql.VmId
}

output "Hostname" {
  description = "postgresql 서버 호스트네임"
  value       = module.postgresql.Hostname
}

output "IpAddress" {
  description = "postgresql 서버 IP 주소"
  value       = module.postgresql.IpAddress
}