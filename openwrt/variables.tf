variable "openwrt_url" {
  type        = string
  description = "OpenWrt router IP address (e.g. 192.168.1.1)"
  default     = "192.168.1.1"
}

variable "openwrt_username" {
  type        = string
  description = "Username for LuCI JSON-RPC API"
  default     = "root"
}

variable "openwrt_password" {
  type        = string
  description = "Password for LuCI JSON-RPC API"
  sensitive   = true
}

variable "wan_device" {
  type        = string
  description = "Physical device for WAN (e.g. eth0)"
  default     = "wan"
}

variable "serivce_lan_devices" {
  type        = list(string)
  description = "Physical devices for the main LAN trunk ports. Untagged traffic is 192.168.0.0/24, tagged VLANs carry service networks."
  default     = ["lan2", "lan3"]
}

variable "client_lan_device" {
  type        = string
  description = "Physical device for LAN1 client network (e.g. eth3)"
  default     = "lan4"
}
