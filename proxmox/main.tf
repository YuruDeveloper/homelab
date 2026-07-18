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
    Alpine   = module.AlpineTemplate.TemplateFileId
    Debian   = module.DebianTemplate.TemplateFileId
    Debian13 = module.Debian13Template.TemplateFileId
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
  AlpineVersion      = "3.23"
  AlpineTemplateDate = "20260116"
}

module "DebianTemplate" {
  source              = "./modules/debian-template"
  ProxmoxNode         = var.proxmox_node
  DatastoreId         = "local"
  DebianVersion       = "12"
  DebianDetailVersion = "12.12-1"
}

module "Debian13Template" {
  source              = "./modules/debian-template"
  ProxmoxNode         = var.proxmox_node
  DatastoreId         = "local"
  DebianVersion       = "13"
  DebianDetailVersion = "13.1-2"
}

module "AlpineVirtIso" {
  source = "./modules/alpine-iso"

  ProxmoxNode   = var.proxmox_node
  DatastoreId   = "local"
  AlpineVersion = "3.24"
}

module "truenas" {
  source = "./services/truenas"

  ProxmoxNode = var.proxmox_node

  VmId        = 200
  DatastoreId = "local-lvm"

}

module "technitium0" {
  source = "./services/dns"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  Hostname  = "technitium0"
  VmId      = 100
  IpAddress = "192.168.2.2/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "technitium1" {
  source = "./services/dns"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  Hostname  = "technitium1"
  VmId      = 101
  IpAddress = "192.168.2.3/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "stepca" {
  source = "./services/stepca"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  Hostname  = "stepca"
  VmId      = 110
  IpAddress = "192.168.2.6/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "haproxy0" {
  source = "./services/haproxy"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine
  Hostname       = "postgresql-haproxy"
  VmId           = 300
  IpAddress      = "192.168.2.20/24"
  Gateway        = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "postgreslave0" {
  source = "./services/postgresql"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  Hostname  = "postgresql0"
  VmId      = 310
  IpAddress = "192.168.2.30/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "postgreslave1" {
  source = "./services/postgresql"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  Hostname  = "postgresql1"
  VmId      = 311
  IpAddress = "192.168.2.31/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "rustfs" {
  source = "./services/rustfs"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  VmId      = 700
  IpAddress = "192.168.2.70/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "haproxy1" {
  source         = "./services/haproxy"
  OsType         = "debian"
  Hostname       = "mongodb-haproxy"
  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Debian

  VmId      = 400
  IpAddress = "192.168.2.21/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.DebianTemplate]
}

module "mongodb0" {
  source         = "./services/mongodb"
  OsType         = "debian"
  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Debian

  Hostname  = "mongodb0"
  VmId      = 410
  IpAddress = "192.168.2.40/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.DebianTemplate]
}

module "mongodb1" {
  source         = "./services/mongodb"
  OsType         = "debian"
  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Debian

  Hostname  = "mongodb1"
  VmId      = 411
  IpAddress = "192.168.2.41/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.DebianTemplate]
}

module "haproxy2" {
  source = "./services/haproxy"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine
  Hostname       = "valkey-haproxy"
  VmId           = 500
  IpAddress      = "192.168.2.22/24"
  Gateway        = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "redis0" {
  source         = "./services/redis"
  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine
  Hostname       = "valkey0"
  VmId           = 510
  IpAddress      = "192.168.2.50/24"
  Gateway        = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}



module "redis1" {
  source         = "./services/redis"
  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine
  Hostname       = "valkey1"
  VmId           = 511
  IpAddress      = "192.168.2.51/24"
  Gateway        = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "docker" {
  source = "./services/docker"

  CommonConfig = local.CommonLxcConfig

  VmId            = 1200
  IpAddress       = "192.168.2.120/24"
  Gateway         = local.Networks.internal.Gateway
  AlpineVirtIsoId = module.AlpineVirtIso.FileId

  depends_on = [module.AlpineVirtIso]
}

module "nginx" {
  source = "./services/nginx"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  VmId      = 3000
  IpAddress = "192.168.5.2/24"
  Gateway   = local.Networks.dmz.Gateway

  depends_on = [module.AlpineTemplate]
}

module "forgejo" {
  source = "./services/forgejo"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  Hostname  = "forgejo"
  VmId      = 1000
  IpAddress = "192.168.2.100/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "zot" {
  source = "./services/zot"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Alpine

  VmId      = 1002
  IpAddress = "192.168.2.102/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "jenkins" {
  source         = "./services/jenkins"
  OsType         = "debian"
  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Debian13

  VmId      = 1001
  IpAddress = "192.168.2.101/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.Debian13Template]
}

module "redpanda" {
  source         = "./services/redpanda"
  OsType         = "debian"
  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Debian13

  VmId      = 800
  IpAddress = "192.168.2.80/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.Debian13Template]
}

module "llamacpp" {
  source = "./services/llamacpp"

  CommonConfig   = local.CommonLxcConfig
  TemplateFileId = local.Templates.Debian

  VmId      = 1300
  IpAddress = "192.168.2.130/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.DebianTemplate]
}

module "claw" {
  source = "./modules/lxc"

  CommonConfig   = local.CommonLxcConfig
  OsType         = "debian"
  TemplateFileId = local.Templates.Debian13

  VmId     = 5000
  Hostname = "claw"

  CpuCores = 2
  Memory   = 2048
  Swap     = 2048
  DiskSize = 64

  IpAddress = "192.168.2.200/24"
  Gateway   = local.Networks.internal.Gateway

  Unprivileged  = true
  EnableKeyctl  = true
  EnableNesting = true

  depends_on = [module.Debian13Template]
}
