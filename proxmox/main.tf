locals {
  CommonLxcConfig = {
    ProxmoxNode     = var.proxmox_node
    ProxmoxUrl      = var.proxmox_url
    ProxmoxUserName = var.proxmox_user_name
    RootPassword    = var.proxmox_password
    PublicKey       = var.public_key
    DatastoreId     = "local-lvm"
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

# ============================================================================
# NFS Mount Configuration
# ============================================================================
# NFS mounts should be configured on Proxmox host (192.168.0.2) via /etc/fstab
# This ensures persistent and stable mounts across reboots.
#
# Setup instructions:
# 1. SSH to Proxmox host: ssh root@192.168.0.2
# 2. Create mount directories:
#    mkdir -p /mnt/postgresql /mnt/git /mnt/gitlarge
# 3. Add to /etc/fstab:
#    192.168.2.10:/mnt/Data/postgresql  /mnt/postgresql  nfs  vers=4,rw,sync,hard  0  0
#    192.168.2.10:/mnt/Data/git         /mnt/git         nfs  vers=4,rw,sync,hard  0  0
#    192.168.2.10:/mnt/Data/gitLarge    /mnt/gitlarge    nfs  vers=4,rw,sync,hard  0  0
# 4. Mount all: mount -a
# 5. Verify: df -h | grep mnt
# ============================================================================

module "technitium0" {
  source = "./services/dns"

  CommonConfig = local.CommonLxcConfig

  VmId      = 200
  IpAddress = "192.168.2.2/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "technitium1" {
  source = "./services/dns"

  CommonConfig = local.CommonLxcConfig

  VmId      = 201
  IpAddress = "192.168.2.3/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "haproxy" {
  source = "./services/haproxy"

  CommonConfig = local.CommonLxcConfig

  VmId      = 500
  IpAddress = "192.168.2.30/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "postgreslave0" {
  source = "./services/postgresql"

  CommonConfig = local.CommonLxcConfig

  VmId      = 510
  IpAddress = "192.168.2.40/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}

module "postgreslave1" {
  source = "./services/postgresql"

  CommonConfig = local.CommonLxcConfig

  VmId      = 511
  IpAddress = "192.168.2.41/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
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

  CommonConfig = local.CommonLxcConfig

  VmId      = 900
  IpAddress = "192.168.5.2/24"
  Gateway   = local.Networks.dmz.Gateway

  depends_on = [module.AlpineTemplate]
}

module "gitea" {
  source = "./services/gitea"

  CommonConfig = local.CommonLxcConfig

  VmId      = 1000
  IpAddress = "192.168.2.80/24"
  Gateway   = local.Networks.internal.Gateway

  depends_on = [module.AlpineTemplate]
}