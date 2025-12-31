resource "proxmox_virtual_environment_file" "DebianTemplate" {
  content_type = "vztmpl"
  datastore_id = var.DatastoreId
  node_name    = var.ProxmoxNode

  source_file {
    path = "http://download.proxmox.com/images/system/debian-${var.DebianVersion}-standard_${var.DebianDetailVersion}_amd64.tar.zst"
  }
}