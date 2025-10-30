module "postgresql" {
  source = "../../modules/lxc-alpine"

  CommonConfig = var.CommonConfig

  VmId     = var.VmId
  Hostname = "postgresql"

  CpuCores = 2
  Memory   = 2048
  Swap     = 0
  DiskSize = 16

  NetworkBridge = "vmbr1"
  VlanId        = 100
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  Unprivileged = true

  MountPoints = [
    {
      volume      = "/mnt/postgresql"
      mount_point = "/mnt/postgresql-wal"
      read_only   = false
    }
  ]
}