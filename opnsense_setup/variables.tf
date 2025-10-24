variable "proxmox_password" {
  type      = string
  sensitive = true
}

variable "proxmox_node" {
  type    = string
  default = "Server"
}
variable "public_key" {
  type = string
}
variable "proxmox_url" {
  type = string
}


variable "proxmox_user_name" {
  type = string
}
variable "proxmox_node_password" {
  type      = string
  sensitive = true
}
