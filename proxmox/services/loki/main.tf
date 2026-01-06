module "loki" {
  source = "../../modules/lxc"

  CommonConfig   = var.CommonConfig
  OsType         = var.OsType
  TemplateFileId = var.TemplateFileId

  VmId     = var.VmId
  Hostname = "loki"

  CpuCores = 2
  Memory   = 2048
  Swap     = 0
  DiskSize = 2

  NetworkBridge = "vmbr1"
  VlanId        = 100
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  Unprivileged = true

  MountPoints = [
    {
      volume      = "/mnt/observability"
      mount_point = "/mnt/observability"
      read_only   = false
    }
  ]
}