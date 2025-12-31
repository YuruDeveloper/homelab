variable "ContainerId" {
  type        = string
  description = "LXC 컨테이너 ID (트리거용)"
}

variable "VmId" {
  type        = number
  description = "LXC 컨테이너 VM ID"
}

variable "ProxmoxUrl" {
  type        = string
  description = "Proxmox 서버 URL"
}

variable "ProxmoxUserName" {
  type        = string
  description = "Proxmox SSH 접속용 사용자명"
}