output "ContainerId" {
  description = "llamacpp 컨테이너 ID"
  value       = module.llamacpp.ContainerId
}

output "VmId" {
  description = "llamacpp VM ID"
  value       = module.llamacpp.VmId
}

output "Hostname" {
  description = "llamacpp 호스트네임"
  value       = module.llamacpp.Hostname
}

output "IpAddress" {
  description = "llamacpp IP 주소"
  value       = module.llamacpp.IpAddress
}
