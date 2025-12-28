variable "ProxmoxNode" {
  description = "The name of the Proxmox node"
  type        = string
}

variable "DatastoreId" {
  description = "The datastore ID for storing the ISO"
  type        = string
  default     = "local"
}

variable "AlpineVersion" {
  description = "The Alpine Linux version (e.g., 3.22)"
  type        = string
  default     = "3.22"
}