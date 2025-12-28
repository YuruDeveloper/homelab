resource "proxmox_virtual_environment_download_file" "AlpineVirtIso" {
  content_type = "iso"
  datastore_id = var.DatastoreId
  node_name    = var.ProxmoxNode
  url          = "https://dl-cdn.alpinelinux.org/alpine/v${var.AlpineVersion}/releases/x86_64/alpine-virt-${var.AlpineVersion}.0-x86_64.iso"
}