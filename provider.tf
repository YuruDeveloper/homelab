terraform {
  required_version = ">= 0.85.0"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.85.0"
    }
  }
}
provider "proxmox" {

  endpoint = "https://${var.proxmox_url}:8006"
  insecure = true
  username = "root@pam"
  password = var.proxmox_node_password
  ssh {
    agent    = true
    username = var.proxmox_user_name
  }
}