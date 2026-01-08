output "ContainerId" {
  description = "zot 서버 컨테이너 ID"
  value       = module.zot.ContainerId
}

output "VmId" {
  description = "zot 서버 VM ID"
  value       = module.zot.VmId
}

output "Hostname" {
  description = "zot 서버 호스트네임"
  value       = module.zot.Hostname
}

output "IpAddress" {
  description = "zot 서버 IP 주소"
  value       = module.zot.IpAddress
}