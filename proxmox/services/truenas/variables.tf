variable "ProxmoxNode" {
  type        = string
  description = "Proxmox 노드 이름"
}

variable "VmId" {
  type        = number
  description = "VM VM ID"
  default     = 1000
}

variable "DatastoreId" {
  type        = string
  description = "데이터스토어 ID"
  default     = "local"
}
