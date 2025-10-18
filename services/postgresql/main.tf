module "postgresql" {
  source = "../../modules/lxc-alpine"

  ProxmoxNode     = var.ProxmoxNode
  ProxmoxUrl      = var.ProxmoxUrl
  ProxmoxUserName = var.ProxmoxUserName

  VmId     = var.VmId
  Hostname = "postgresql"

  CpuCores = 2
  Memory   = 2024
  Swap     = 0
  DiskSize = 2

  NetworkBridge = "vmbr1"
  VlanId        = 100
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  RootPassword = var.RootPassword
  PublicKey    = var.PublicKey

  DatastoreId  = var.DatastoreId
  Unprivileged = true
}