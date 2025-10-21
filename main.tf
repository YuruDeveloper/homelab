module "AlpineTemplate" {
  source = "./modules/alpine-template"

  ProxmoxNode        = var.proxmox_node
  DatastoreId        = "local"
  AlpineVersion      = "3.22"
  AlpineTemplateDate = "20250617"
}

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

  DatastoreId     = "local"
  TemplateFileId  = module.AlpineTemplate.TemplateFileId
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

  DatastoreId     = "local"
  TemplateFileId  = module.AlpineTemplate.TemplateFileId
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

  DatastoreId     = "local"
  TemplateFileId  = module.AlpineTemplate.TemplateFileId
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

  DatastoreId     = "local"
  TemplateFileId  = module.AlpineTemplate.TemplateFileId
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

  DatastoreId     = "local"
  TemplateFileId  = module.AlpineTemplate.TemplateFileId
}

module "docker" {
  source = "./services/docker"

  ProxmoxNode     = var.proxmox_node
  ProxmoxUrl      = var.proxmox_url
  ProxmoxUserName = var.proxmox_user_name

  VmId = 1005

  IpAddress     = "192.168.2.105/24"
  Gateway       = "192.168.2.1"

  RootPassword = var.proxmox_password
  PublicKey    = var.public_key

  DatastoreId     = "local"
  TemplateFileId  = module.AlpineTemplate.TemplateFileId
}

module "nginx" {
  source = "./services/nginx"

  ProxmoxNode     = var.proxmox_node
  ProxmoxUrl      = var.proxmox_url
  ProxmoxUserName = var.proxmox_user_name

  VmId = 1006

  IpAddress     = "192.168.5.100/24"
  Gateway       = "192.168.5.1"

  RootPassword = var.proxmox_password
  PublicKey    = var.public_key

  DatastoreId     = "local"
  TemplateFileId  = module.AlpineTemplate.TemplateFileId
}

module "gitea" {
  source = "./services/gitea"

  ProxmoxNode     = var.proxmox_node
  ProxmoxUrl      = var.proxmox_url
  ProxmoxUserName = var.proxmox_user_name

  VmId = 1007

  IpAddress     = "192.168.2.106/24"
  Gateway       = "192.168.2.1"

  RootPassword = var.proxmox_password
  PublicKey    = var.public_key

  DatastoreId     = "local"
  TemplateFileId  = module.AlpineTemplate.TemplateFileId
}