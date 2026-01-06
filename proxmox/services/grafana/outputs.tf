output "ContainerId" {
  description = "grafana 서버 컨테이너 ID"
  value       = module.grafana.ContainerId
}

output "VmId" {
  description = "grafana 서버 VM ID"
  value       = module.grafana.VmId
}

output "Hostname" {
  description = "grafana 서버 호스트네임"
  value       = module.grafana.Hostname
}

output "IpAddress" {
  description = "grafana 서버 IP 주소"
  value       = module.grafana.IpAddress
}