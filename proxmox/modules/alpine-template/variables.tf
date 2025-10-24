variable "ProxmoxNode" {
  type        = string
  description = "Proxmox 노드 이름"
}

variable "DatastoreId" {
  type        = string
  description = "데이터스토어 ID"
  default     = "local"
}

variable "AlpineVersion" {
  type        = string
  description = "Alpine Linux 버전"
  default     = "3.22"
}

variable "AlpineTemplateDate" {
  type        = string
  description = "Alpine 템플릿 날짜"
  default     = "20250617"
}