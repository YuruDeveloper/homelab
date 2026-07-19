module "llamacpp" {
  source = "../../modules/lxc"

  CommonConfig   = var.CommonConfig
  OsType         = "debian"
  TemplateFileId = var.TemplateFileId

  VmId     = var.VmId
  Hostname = "llamacpp"

  CpuCores = 1
  Memory   = 512
  Swap     = 512
  DiskSize = 32

  NetworkBridge = "vmbr0"
  VlanId        = 100
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  Unprivileged = true

  DevicePassthrough = [
    {
      path = "/dev/dri/renderD128"
      mode = "0666"
    },
    {
      path = "/dev/dri/card0"
      mode = "0666"
    }
  ]
}
