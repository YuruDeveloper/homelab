locals {
  CommonLxcConfig = {
    ProxmoxNode     = var.proxmox_node
    ProxmoxUrl      = var.proxmox_url
    ProxmoxUserName = var.proxmox_user_name
    RootPassword    = var.proxmox_password
    PublicKey       = var.public_key
    DatastoreId     = "local-lvm"
  }

  Templates = {
    Alpine = module.AlpineTemplate.TemplateFileId
    Debian = module.DebianTemplate.TemplateFileId
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

module "DebianTemplate" {
  source = "./modules/debian-template"
  ProxmoxNode        = var.proxmox_node
  DatastoreId        = "local"
  DebianVersion = "13"
  DebianDetailVersion = "13.1-2"
}

module "AlpineVirtIso" {
  source = "./modules/alpine-iso"

  ProxmoxNode   = var.proxmox_node
  DatastoreId   = "local"
  AlpineVersion = "3.23"
}

module "truenas" {
  source = "./services/truenas"

  ProxmoxNode = var.proxmox_node

  VmId        = 300
  DatastoreId = "local-lvm"

}

module "technitium0" {
  source = "./services/dns"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  VmId      = 200
  IpAddress = "192.168.2.2/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "technitium1" {
  source = "./services/dns"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  VmId      = 201
  IpAddress = "192.168.2.3/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "haproxy0" {
  source = "./services/haproxy"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine
  DiskSize = 1
  VmId      = 500
  IpAddress = "192.168.2.30/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "postgreslave0" {
  source = "./services/postgresql"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  VmId      = 510
  IpAddress = "192.168.2.40/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "postgreslave1" {
  source = "./services/postgresql"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  VmId      = 511
  IpAddress = "192.168.2.41/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "rustfs" {
  source = "./services/rustfs"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  VmId      = 600
  IpAddress = "192.168.2.50/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "haproxy1" {
  source = "./services/haproxy"
  OsType = "debian"
  DiskSize = 2
  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Debian

  VmId = 700
  IpAddress = "192.168.2.31/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.DebianTemplate]
}

module "mongodb0" {
  source = "./services/mongodb"
  OsType = "debian"
  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Debian

  VmId = 710
  IpAddress = "192.168.2.60/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.DebianTemplate]
}

module "mongodb1" {
  source = "./services/mongodb"
  OsType = "debian"
  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Debian

  VmId = 711
  IpAddress = "192.168.2.61/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.DebianTemplate]
}

module "docker" {
  source = "./services/docker"

  CommonConfig = local.CommonLxcConfig
  
  VmId            = 400
  IpAddress       = "192.168.2.20/24"
  Gateway         = local.Networks.internal.Gateway
  AlpineVirtIsoId = module.AlpineVirtIso.FileId

  depends_on = [module.AlpineVirtIso]
}

module "nginx" {
  source = "./services/nginx"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  VmId      = 900
  IpAddress = "192.168.5.2/24"
  Gateway   = local.Networks.dmz.Gateway

  depends_on = [module.AlpineTemplate]
}

module "gitea" {
  source = "./services/gitea"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  VmId      = 1000
  IpAddress = "192.168.2.80/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}