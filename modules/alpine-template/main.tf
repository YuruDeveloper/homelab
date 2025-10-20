resource "proxmox_virtual_environment_file" "AlpineTemplate" {
  content_type = "vztmpl"
  datastore_id = var.DatastoreId
  node_name    = var.ProxmoxNode

  source_file {
    path = "http://download.proxmox.com/images/system/alpine-${var.AlpineVersion}-default_${var.AlpineTemplateDate}_amd64.tar.xz"
  }
}