# ============================================
# VLAN 설정
# ============================================

# VLAN 100 - Service (내부 서비스)
resource "opnsense_interfaces_vlan" "Vlan100Service" {
  parent      = "vtnet1"  # 물리 인터페이스 (LAN)
  device = "vlan0.100"
  tag         = 100
  priority    = 3
  description = "Service VLAN - Internal Services (DNS, DB, Docker)"
}

# VLAN 200 - Kubernetes
resource "opnsense_interfaces_vlan" "Vlan200Kubernetes" {
  parent      = "vtnet1"  # 물리 인터페이스 (LAN)
  device = "vlan0.200"
  tag         = 200
  priority    = 3
  description = "Kubernetes VLAN - K8s Cluster"
}

# VLAN 300 - Container (Docker macvlan)
resource "opnsense_interfaces_vlan" "Vlan300Container" {
  parent      = "vtnet1"  # 물리 인터페이스 (LAN)
   device = "vlan0.300"
  tag         = 300
  priority    = 3
  description = "Container VLAN - Docker Containers"
}

# VLAN 400 - DMZ
resource "opnsense_interfaces_vlan" "Vlan400Dmz" {
  parent      = "vtnet1"  # 물리 인터페이스 (LAN)
   device = "vlan0.400"
  tag         = 400
  priority    = 3
  description = "DMZ VLAN - External Facing Services"
}