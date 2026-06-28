terraform {
  required_version = ">= 1.0.0"
  required_providers {
    openwrt = {
      source  = "bucksbunni/openwrt"
      version = "~> 0.1.0"
    }
  }
}

provider "openwrt" {
  host     = "http://${var.openwrt_url}"
  username = var.openwrt_username
  password = var.openwrt_password
  insecure = true
}
