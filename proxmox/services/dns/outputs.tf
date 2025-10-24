output "ContainerId" {
  description = "DNS 서버 컨테이너 ID"
  value       = module.dns.ContainerId
}

output "VmId" {
  description = "DNS 서버 VM ID"
  value       = module.dns.VmId
}

output "Hostname" {
  description = "DNS 서버 호스트네임"
  value       = module.dns.Hostname
}

output "IpAddress" {
  description = "DNS 서버 IP 주소"
  value       = module.dns.IpAddress
}