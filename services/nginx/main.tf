module "haproxy" {
  source = "../../modules/lxc-alpine"

  ProxmoxNode     = var.ProxmoxNode
  ProxmoxUrl      = var.ProxmoxUrl
  ProxmoxUserName = var.ProxmoxUserName

  VmId     = var.VmId
  Hostname = "nginx"

  CpuCores = 1
  Memory   = 512
  Swap     = 0
  DiskSize = 1

  NetworkBridge = "vmbr1"
  VlanId        = 400
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  Dns = [ "8.8.8.8" , "8.8.4.4" ]

  RootPassword = var.RootPassword
  PublicKey    = var.PublicKey

  DatastoreId  = var.DatastoreId
  Unprivileged = true

  TemplateFileId = var.TemplateFileId
}