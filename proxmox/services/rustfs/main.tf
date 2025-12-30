module "rustfs" {
  source = "../../modules/lxc-alpine"

  CommonConfig = var.CommonConfig

  VmId     = var.VmId
  Hostname = "rustfs"

  CpuCores = 2
  Memory   = 2048
  Swap     = 0
  DiskSize = 4

  NetworkBridge = "vmbr1"
  VlanId        = 100
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  Unprivileged = true

  MountPoints = [
    {
      volume      = "/mnt/objectstorage"
      mount_point = "/mnt/objectstorage"
      read_only   = false
    }
  ]
}