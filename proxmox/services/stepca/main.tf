module "stepca" {
  source = "../../modules/lxc"

  CommonConfig   = var.CommonConfig
  OsType         = var.OsType
  TemplateFileId = var.TemplateFileId

  VmId     = var.VmId
  Hostname = var.Hostname

  CpuCores = 1
  Memory   = 512
  Swap     = 512
  DiskSize = 8

  NetworkBridge = "vmbr0"
  VlanId        = 100
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  Unprivileged = true
}
