variable "ProxmoxNode" {
  type        = string
  description = "Proxmox 노드 이름"
}

variable "DatastoreId" {
  type        = string
  description = "데이터스토어 ID"
  default     = "local"
}

variable "DebianVersion" {
  type        = string
  description = "Debian Linux 버전"
  default     = "13"
}

variable "DebianDetailVersion" {
  type        = string
  description = "Debian 상세 버전"
  default     = "13.1-2"
}