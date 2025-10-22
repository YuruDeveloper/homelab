module "haproxy" {
  source = "../../modules/lxc-alpine"

  CommonConfig = var.CommonConfig

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

  Dns = ["8.8.8.8", "8.8.4.4"]

  Unprivileged = true
}