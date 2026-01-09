module "nginx" {
  source = "../../modules/lxc"

  CommonConfig   = var.CommonConfig
  OsType         = var.OsType
  TemplateFileId = var.TemplateFileId

  VmId     = var.VmId
  Hostname = "nginx"

  CpuCores = 1
  Memory   = 512
  Swap     = 0
  DiskSize = 5

  NetworkBridge = "vmbr1"
  VlanId        = 400
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  Dns = ["1.1.1.1", "8.8.8.8"]

  Unprivileged = true
}