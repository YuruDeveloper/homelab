variable "ProxmoxNode" {
  type        = string
  description = "Proxmox 노드 이름"
}

variable "ProxmoxUrl" {
  type        = string
  description = "Proxmox 서버 URL"
}

variable "ProxmoxUserName" {
  type        = string
  description = "Proxmox SSH 접속용 사용자명"
}

variable "VmId" {
  type        = number
  description = "LXC 컨테이너 VM ID"
  default     = 1000
}

variable "DatastoreId" {
  type        = string
  description = "데이터스토어 ID"
  default     = "local"
}

variable "IpAddress" {
  type        = string
  description = "IP 주소 (CIDR 표기법, 예: 192.168.2.100/24)"
  default     = "192.168.2.100/24"
}

variable "Gateway" {
  type        = string
  description = "게이트웨이 IP 주소"
  default     = "192.168.2.1"
}

variable "RootPassword" {
  type        = string
  description = "Root 패스워드"
  sensitive   = true
}

variable "PublicKey" {
  type        = string
  description = "SSH 공개키"
}

variable "TemplateFileId" {
  type        = string
  description = "Alpine 템플릿 파일 ID"
}
