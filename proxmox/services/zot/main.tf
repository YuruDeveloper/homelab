module "zot" {
  source = "../../modules/lxc"

  CommonConfig   = var.CommonConfig
  OsType         = var.OsType
  TemplateFileId = var.TemplateFileId

  VmId     = var.VmId
  Hostname = "zot"

  CpuCores = 1
  Memory   = 512
  Swap     = 512
  DiskSize = 5

  NetworkBridge = "vmbr1"
  VlanId        = 100
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  Unprivileged = true

  MountPoints = [
    {
      volume      = "/mnt/zot"
      mount_point = "/mnt/zot"
      read_only   = false
    }
  ]
}