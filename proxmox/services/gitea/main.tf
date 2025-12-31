module "gitea" {
  source = "../../modules/lxc"

  CommonConfig   = var.CommonConfig
  OsType         = var.OsType
  TemplateFileId = var.TemplateFileId

  VmId     = var.VmId
  Hostname = "gitea"

  CpuCores = 1
  Memory   = 4096
  Swap     = 0
  DiskSize = 2

  NetworkBridge = "vmbr1"
  VlanId        = 100
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  Unprivileged = true

  MountPoints = [
    {
      volume      = "/mnt/git"
      mount_point = "/var/lib/gitea/data/gitea-repositories"
      read_only   = false
    },
    {
      volume      = "/mnt/gitlarge"
      mount_point = "/var/lib/gitea/data/lfs"
      read_only   = false
    }
  ]
}