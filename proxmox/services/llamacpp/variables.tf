variable "CommonConfig" {
  type = object({
    ProxmoxNode     = string
    ProxmoxUrl      = string
    ProxmoxUserName = string
    RootPassword    = string
    PublicKey       = string
    DatastoreId     = string
  })
  description = "LXC 공통 설정 (Proxmox 연결 정보 및 인증 정보)"
  sensitive   = true
}

variable "TemplateFileId" {
  type        = string
  description = "LXC 템플릿 파일 ID"
}

variable "VmId" {
  type        = number
  description = "LXC 컨테이너 VM ID"
}

variable "IpAddress" {
  type        = string
  description = "IP 주소 (CIDR 표기법, 예: 192.168.2.110/24)"
}

variable "Gateway" {
  type        = string
  description = "게이트웨이 IP 주소"
}
