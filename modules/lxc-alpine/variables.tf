variable "ProxmoxNode" {
  type        = string
  description = "Proxmox 노드 이름"
}

variable "VmId" {
  type        = number
  description = "LXC 컨테이너 VM ID"
}

variable "Hostname" {
  type        = string
  description = "컨테이너 호스트네임"
}

variable "CpuCores" {
  type        = number
  description = "CPU 코어 수"
  default     = 1
}

variable "Memory" {
  type        = number
  description = "메모리 크기 (MB)"
  default     = 512
}

variable "Swap" {
  type        = number
  description = "Swap 크기 (MB)"
  default     = 0
}

variable "DiskSize" {
  type        = number
  description = "디스크 크기 (GB)"
  default     = 1
}

variable "DatastoreId" {
  type        = string
  description = "데이터스토어 ID"
  default     = "local"
}

variable "NetworkBridge" {
  type        = string
  description = "네트워크 브리지"
  default     = "vmbr1"
}

variable "VlanId" {
  type        = number
  description = "VLAN ID"
  default     = 100
}

variable "IpAddress" {
  type        = string
  description = "IP 주소 (CIDR 표기법, 예: 192.168.2.100/24)"
}

variable "Gateway" {
  type        = string
  description = "게이트웨이 IP 주소"
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

variable "ProxmoxUrl" {
  type        = string
  description = "Proxmox 서버 URL"
}

variable "ProxmoxUserName" {
  type        = string
  description = "Proxmox SSH 접속용 사용자명"
}

variable "Unprivileged" {
  type        = bool
  description = "Unprivileged 컨테이너 여부"
  default     = true
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