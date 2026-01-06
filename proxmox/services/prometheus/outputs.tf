output "ContainerId" {
  description = "prmetheus 서버 컨테이너 ID"
  value       = module.prometheus.ContainerId
}

output "VmId" {
  description = "prmetheus 서버 VM ID"
  value       = module.prometheus.VmId
}

output "Hostname" {
  description = "prmetheus 서버 호스트네임"
  value       = module.prometheus.Hostname
}

output "IpAddress" {
  description = "prmetheus 서버 IP 주소"
  value       = module.prometheus.IpAddress
}