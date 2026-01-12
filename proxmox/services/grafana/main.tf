module "grafana" {
  source = "../../modules/lxc"

  CommonConfig   = var.CommonConfig
  OsType         = var.OsType
  TemplateFileId = var.TemplateFileId

  VmId     = var.VmId
  Hostname = "grafana"

  CpuCores = 1
  Memory   = 512
  Swap     = 512
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