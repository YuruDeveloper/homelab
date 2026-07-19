module "mongodb" {
  source = "../../modules/lxc"

  CommonConfig   = var.CommonConfig
  OsType         = var.OsType
  TemplateFileId = var.TemplateFileId

  VmId     = var.VmId
  Hostname = var.Hostname

  CpuCores = 2
  Memory   = 1024
  Swap     = 512
  DiskSize = 20

  NetworkBridge = "vmbr0"
  VlanId        = 100
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  Unprivileged = true

  MountPoints = [
    {
      volume      = "/mnt/mongodb"
      mount_point = "/mnt/mongodb"
      read_only   = false
    }
  ]
}
