variable "proxmox_password" {
  type      = string
  sensitive = true
}

variable "proxmox_node" {
  type    = string
  default = "Server"
}
variable "public_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG+/E09hXBSOg6DfQr2vattC2NrYlOZYv4FehRGmNw4k cecil@STDDESKTOP"
}
variable "proxmox_url" {
  type = string
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "proxmox_user_name" {
  type = string
}
variable "proxmox_node_password" {
  type      = string
  sensitive = true
}
