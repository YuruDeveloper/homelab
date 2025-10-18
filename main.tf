module "TestDns" {
  source = "./modules/lxc-alpine"

  ProxmoxNode     = var.proxmox_node
  ProxmoxUrl      = var.proxmox_url
  ProxmoxUserName = var.proxmox_user_name

  VmId     = 1000
  Hostname = "testdns"

  CpuCores = 1
  Memory   = 512
  Swap     = 0
  DiskSize = 1

  NetworkBridge = "vmbr1"
  VlanId        = 100
  IpAddress     = "192.168.2.100/24"
  Gateway       = "192.168.2.1"

  RootPassword = var.proxmox_pasword
  PublicKey    = var.public_key

  DatastoreId = "local"
  Unprivileged = true
}