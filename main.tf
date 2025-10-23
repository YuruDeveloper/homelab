locals {
  CommonLxcConfig = {
    ProxmoxNode     = var.proxmox_node
    ProxmoxUrl      = var.proxmox_url
    ProxmoxUserName = var.proxmox_user_name
    RootPassword    = var.proxmox_password
    PublicKey       = var.public_key
    DatastoreId     = "local"
    TemplateFileId  = module.AlpineTemplate.TemplateFileId
  }

  Networks = {
    internal = {
      Gateway = "192.168.2.1"
      Subnet  = "192.168.2.0/24"
    }
    dmz = {
      Gateway = "192.168.5.1"
      Subnet  = "192.168.5.0/24"
    }
  }
}

module "AlpineTemplate" {
  source = "./modules/alpine-template"

  ProxmoxNode        = var.proxmox_node
  DatastoreId        = "local"
  AlpineVersion      = "3.22"
  AlpineTemplateDate = "20250617"
}

module "truenas" {
  source = "./services/truenas"

  ProxmoxNode = var.proxmox_node

  VmId        = 1008
  DatastoreId = "local"

}

module "technitium0" {
  source = "./services/dns"

  CommonConfig = local.CommonLxcConfig

  VmId      = 1000
  IpAddress = "192.168.2.100/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "technitium1" {
  source = "./services/dns"

  CommonConfig = local.CommonLxcConfig

  VmId      = 1001
  IpAddress = "192.168.2.101/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "haproxy" {
  source = "./services/haproxy"

  CommonConfig = local.CommonLxcConfig

  VmId      = 1002
  IpAddress = "192.168.2.102/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "postgreslave0" {
  source = "./services/postgresql"

  CommonConfig = local.CommonLxcConfig

  VmId      = 1003
  IpAddress = "192.168.2.103/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "postgreslave1" {
  source = "./services/postgresql"

  CommonConfig = local.CommonLxcConfig

  VmId      = 1004
  IpAddress = "192.168.2.104/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "docker" {
  source = "./services/docker"

  CommonConfig = local.CommonLxcConfig

  VmId      = 1005
  IpAddress = "192.168.2.105/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "nginx" {
  source = "./services/nginx"

  CommonConfig = local.CommonLxcConfig

  VmId      = 1006
  IpAddress = "192.168.5.100/24"
  Gateway   = local.Networks.dmz.Gateway

  depends_on = [module.AlpineTemplate]
}

module "gitea" {
  source = "./services/gitea"

  CommonConfig = local.CommonLxcConfig

  VmId      = 1007
  IpAddress = "192.168.2.106/24"
  Gateway   = local.Networks.internal.Gateway

 depends_on = [module.AlpineTemplate]
}