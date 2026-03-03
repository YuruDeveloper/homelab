module "llamacpp" {
  source = "../../modules/lxc"

  CommonConfig   = var.CommonConfig
  OsType         = "debian"
  TemplateFileId = var.TemplateFileId

  VmId     = var.VmId
  Hostname = "llamacpp"

  CpuCores = 2
  Memory   = 2048
  Swap     = 2560
  DiskSize = 32

  NetworkBridge = "vmbr1"
  VlanId        = 100
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  Unprivileged  = true
  EnableNesting = true

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
