module "gitea" {
  source = "../../modules/lxc-alpine"

  CommonConfig = var.CommonConfig

  VmId     = var.VmId
  Hostname = "gitea"

  CpuCores = 1
  Memory   = 4096
  Swap     = 0
  DiskSize = 2

  NetworkBridge = "vmbr1"
  VlanId        = 100
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  Unprivileged = true
}