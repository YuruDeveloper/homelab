terraform {
    required_version = ">= 1.0.0"
    required_providers {
      opnsense = {
        source = "browningluke/opnsense"
        version = "~> 0.15.0"
      }
    }
}

provider "opnsense" {
    uri = "http://${var.opnsense_url}"
    api_key = var.api_key
    api_secret = var.api_secret
}