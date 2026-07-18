output "FileId" {
  description = "The file ID of the downloaded Alpine virt ISO"
  value       = proxmox_download_file.AlpineVirtIso.id
}
