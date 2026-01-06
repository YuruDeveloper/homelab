output "ContainerId" {
  description = "loki 서버 컨테이너 ID"
  value       = module.loki.ContainerId
}

output "VmId" {
  description = "loki 서버 VM ID"
  value       = module.loki.VmId
}

output "Hostname" {
  description = "loki 서버 호스트네임"
  value       = module.loki.Hostname
}

output "IpAddress" {
  description = "loki 서버 IP 주소"
  value       = module.loki.IpAddress
}