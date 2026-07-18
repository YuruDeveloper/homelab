output "ContainerId" {
  description = "CA 서버 컨테이너 ID"
  value       = module.stepca.ContainerId
}

output "VmId" {
  description = "CA 서버 VM ID"
  value       = module.stepca.VmId
}

output "Hostname" {
  description = "CA 서버 호스트네임"
  value       = module.stepca.Hostname
}

output "IpAddress" {
  description = "CA 서버 IP 주소"
  value       = module.stepca.IpAddress
}