module "postgresql" {
  source = "../../modules/lxc"

  CommonConfig   = var.CommonConfig
  OsType         = var.OsType
  TemplateFileId = var.TemplateFileId

  VmId     = var.VmId
  Hostname = "postgresql"

  CpuCores = 2
  Memory   = 1024
  Swap     = 512
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