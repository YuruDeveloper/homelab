module "dns" {
  source = "../../modules/lxc-alpine"

  CommonConfig = var.CommonConfig

  VmId     = var.VmId
  Hostname = "technitium"

  CpuCores = 1
  Memory   = 512
  Swap     = 0
  DiskSize = 1

  NetworkBridge = "vmbr1"
  VlanId        = 100
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  Unprivileged = true
}