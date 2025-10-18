module "technitium0" {
  source = "./services/dns"

  ProxmoxNode     = var.proxmox_node
  ProxmoxUrl      = var.proxmox_url
  ProxmoxUserName = var.proxmox_user_name

  VmId = 1000

  IpAddress     = "192.168.2.100/24"
  Gateway       = "192.168.2.1"

  RootPassword = var.proxmox_password
  PublicKey    = var.public_key

  DatastoreId  = "local"
}

module "technitium1" {
  source = "./services/dns"

  ProxmoxNode     = var.proxmox_node
  ProxmoxUrl      = var.proxmox_url
  ProxmoxUserName = var.proxmox_user_name

  VmId = 1001

  IpAddress     = "192.168.2.101/24"
  Gateway       = "192.168.2.1"

  RootPassword = var.proxmox_password
  PublicKey    = var.public_key

  DatastoreId  = "local"
}

module "haproxy" {
  source = "./services/haproxy"

  ProxmoxNode     = var.proxmox_node
  ProxmoxUrl      = var.proxmox_url
  ProxmoxUserName = var.proxmox_user_name

  VmId = 1002

  IpAddress     = "192.168.2.102/24"
  Gateway       = "192.168.2.1"

  RootPassword = var.proxmox_password
  PublicKey    = var.public_key

  DatastoreId  = "local"
}

module "postgreslave0" {
  source = "./services/postgresql"

  ProxmoxNode     = var.proxmox_node
  ProxmoxUrl      = var.proxmox_url
  ProxmoxUserName = var.proxmox_user_name

  VmId = 1003

  IpAddress     = "192.168.2.103/24"
  Gateway       = "192.168.2.1"

  RootPassword = var.proxmox_password
  PublicKey    = var.public_key

  DatastoreId  = "local"
}

module "postgreslave1" {
  source = "./services/postgresql"

  ProxmoxNode     = var.proxmox_node
  ProxmoxUrl      = var.proxmox_url
  ProxmoxUserName = var.proxmox_user_name

  VmId = 1004

  IpAddress     = "192.168.2.104/24"
  Gateway       = "192.168.2.1"

  RootPassword = var.proxmox_password
  PublicKey    = var.public_key

  DatastoreId  = "local"
}