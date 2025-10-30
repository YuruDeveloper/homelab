variable "CommonConfig" {
  type = object({
    ProxmoxNode     = string
    ProxmoxUrl      = string
    ProxmoxUserName = string
    RootPassword    = string
    PublicKey       = string
    DatastoreId     = string
    TemplateFileId  = string
  })
  description = "LXC 공통 설정 (Proxmox 연결 정보 및 인증 정보)"
  sensitive   = true
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

variable "Unprivileged" {
  type        = bool
  description = "Unprivileged 컨테이너 여부"
  default     = true
}

variable "EnableNesting" {
  type        = bool
  description = "Docker 등 중첩 컨테이너 지원 활성화"
  default     = false
}

variable "EnableKeyctl" {
  type        = bool
  description = "Keyctl 기능 활성화"
  default     = false
}

variable "AdditionalNetworkInterfaces" {
  type = list(object({
    name    = string
    vlan_id = number
    bridge  = string
  }))
  description = "추가 네트워크 인터페이스 목록"
  default     = []
}

variable "Dns" {
  type = list(string)
  description = "dns 설정"
  default = []
}

variable "MountPoints" {
  type = list(object({
    volume      = string
    mount_point = string
    read_only   = bool
  }))
  description = "마운트 포인트 목록 (bind mount). volume 형식: 'mp=/호스트/경로' (Proxmox 호스트의 디렉토리를 컨테이너에 bind mount)"
  default     = []
}