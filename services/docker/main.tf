module "docker" {
  source = "../../modules/lxc-alpine"

  ProxmoxNode     = var.ProxmoxNode
  ProxmoxUrl      = var.ProxmoxUrl
  ProxmoxUserName = var.ProxmoxUserName

  VmId     = var.VmId
  Hostname = "docker"

  # Docker 전용 리소스 설정
  CpuCores = 4
  Memory   = 4096
  Swap     = 1024
  DiskSize = 16

  # Docker 전용 Features
  EnableNesting = true
  EnableKeyctl  = true

  # 기본 네트워크 (eth0)
  NetworkBridge = "vmbr1"
  VlanId        = 100
  IpAddress     = var.IpAddress
  Gateway       = var.Gateway

  # 추가 네트워크 인터페이스 (eth1)
  AdditionalNetworkInterfaces = [
    {
      name    = "eth1"
      vlan_id = 300
      bridge  = "vmbr1"
    }
  ]

  RootPassword = var.RootPassword
  PublicKey    = var.PublicKey

  DatastoreId    = var.DatastoreId
  Unprivileged   = true
  TemplateFileId = var.TemplateFileId
}
