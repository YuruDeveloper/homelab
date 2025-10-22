module "docker" {
  source = "../../modules/lxc-alpine"

  CommonConfig = var.CommonConfig

  VmId     = var.VmId
  Hostname = "docker"

  CpuCores = 4
  Memory   = 4096
  Swap     = 1024
  DiskSize = 16

  EnableNesting = true
  EnableKeyctl  = true

  NetworkBridge = "vmbr1"
  VlanId        = 100
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  AdditionalNetworkInterfaces = [
    {
      name    = "eth1"
      vlan_id = 300
      bridge  = "vmbr1"
    }
  ]

  Unprivileged = true
}
