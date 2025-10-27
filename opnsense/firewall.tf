# ============================================
# 방화벽 규칙 - LAN (Hardware Network)
# ============================================

# LAN - Allow all to any
resource "opnsense_firewall_filter" "LanToAny" {
  enabled     = true
  sequence    = 1
  action      = "pass"
  quick       = true
  interface   = ["lan"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "any"

  source = {
    net = "lan"
  }

  destination = {
    net = "any"
  }

  description = "Default allow LAN to any rule"
}

# LAN IPv6 - Allow all to any
resource "opnsense_firewall_filter" "LanToAnyIpv6" {
  enabled     = true
  sequence    = 2
  action      = "pass"
  quick       = true
  interface   = ["lan"]
  direction   = "in"
  ip_protocol = "inet6"
  protocol    = "any"

  source = {
    net = "lan"
  }

  destination = {
    net = "any"
  }

  description = "Default allow LAN IPv6 to any rule"
}

# ============================================
# 방화벽 규칙 - LAN1 (클라이언트 네트워크)
# ============================================

# LAN1 (192.168.1.0/24) - Allow all to any
resource "opnsense_firewall_filter" "Lan1ToAny" {
  enabled     = true
  sequence    = 10
  action      = "pass"
  quick       = true
  interface   = ["opt1"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "any"

  source = {
    net = "opt1"
  }

  destination = {
    net = "any"
  }

  description = "Default allow LAN1 to any rule"
}

# LAN1 IPv6 - Allow all to any
resource "opnsense_firewall_filter" "Lan1ToAnyIpv6" {
  enabled     = true
  sequence    = 11
  action      = "pass"
  quick       = true
  interface   = ["opt1"]
  direction   = "in"
  ip_protocol = "inet6"
  protocol    = "any"

  source = {
    net = "opt1"
  }

  destination = {
    net = "any"
  }

  description = "Default allow LAN1 IPv6 to any rule"
}

# ============================================
# 방화벽 규칙 - Service VLAN (192.168.2.0/24)
# ============================================

# Service VLAN - Allow all to any
resource "opnsense_firewall_filter" "ServiceToAny" {
  enabled     = true
  sequence    = 20
  action      = "pass"
  quick       = true
  interface   = ["opt2"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "any"

  source = {
    net = "opt2"
  }

  destination = {
    net = "any"
  }

  description = "Default allow Service VLAN to any rule"
}

# Service VLAN IPv6 - Allow all to any
resource "opnsense_firewall_filter" "ServiceToAnyIpv6" {
  enabled     = true
  sequence    = 21
  action      = "pass"
  quick       = true
  interface   = ["opt2"]
  direction   = "in"
  ip_protocol = "inet6"
  protocol    = "any"

  source = {
    net = "opt2"
  }

  destination = {
    net = "any"
  }

  description = "Default allow Service VLAN IPv6 to any rule"
}

# ============================================
# 방화벽 규칙 - Kubernetes VLAN (192.168.3.0/24)
# ============================================

# Kubernetes → Technitium DNS #1
resource "opnsense_firewall_filter" "K8sToDns1" {
  enabled     = true
  sequence    = 30
  action      = "pass"
  quick       = true
  interface   = ["opt3"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "UDP"

  source = {
    net = "opt3"
  }

  destination = {
    net  = "192.168.2.2/32"
    port = "53"
  }

  description = "Allow Kubernetes to DNS Server #1"
}

# Kubernetes → Technitium DNS #2
resource "opnsense_firewall_filter" "K8sToDns2" {
  enabled     = true
  sequence    = 31
  action      = "pass"
  quick       = true
  interface   = ["opt3"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "UDP"

  source = {
    net = "opt3"
  }

  destination = {
    net  = "192.168.2.3/32"
    port = "53"
  }

  description = "Allow Kubernetes to DNS Server #2"
}

# Kubernetes → Block internal networks
resource "opnsense_firewall_filter" "K8sBlockInternal" {
  enabled     = true
  sequence    = 32
  action      = "block"
  quick       = true
  interface   = ["opt3"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "any"

  source = {
    net = "opt3"
  }

  destination = {
    net = "192.168.0.0/16"
  }

  description = "Block Kubernetes access to internal networks"
}

# Kubernetes → Allow Internet
resource "opnsense_firewall_filter" "K8sToInternet" {
  enabled     = true
  sequence    = 33
  action      = "pass"
  quick       = true
  interface   = ["opt3"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "any"

  source = {
    net = "opt3"
  }

  destination = {
    net = "any"
  }

  description = "Allow Kubernetes to Internet"
}

# Kubernetes IPv6 → Allow Internet
resource "opnsense_firewall_filter" "K8sToInternetIpv6" {
  enabled     = true
  sequence    = 34
  action      = "pass"
  quick       = true
  interface   = ["opt3"]
  direction   = "in"
  ip_protocol = "inet6"
  protocol    = "any"

  source = {
    net = "opt3"
  }

  destination = {
    net = "any"
  }

  description = "Allow Kubernetes IPv6 to Internet"
}

# ============================================
# 방화벽 규칙 - Container VLAN (192.168.4.0/24)
# ============================================

# Container → Block internal networks
resource "opnsense_firewall_filter" "ContainerBlockInternal" {
  enabled     = true
  sequence    = 40
  action      = "block"
  quick       = true
  interface   = ["opt4"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "any"

  source = {
    net = "opt4"
  }

  destination = {
    net = "192.168.0.0/16"
  }

  description = "Block Container access to internal networks"
}

# Container → Allow Internet
resource "opnsense_firewall_filter" "ContainerToInternet" {
  enabled     = true
  sequence    = 41
  action      = "pass"
  quick       = true
  interface   = ["opt4"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "any"

  source = {
    net = "opt4"
  }

  destination = {
    net = "any"
  }

  description = "Allow Container to Internet"
}

# Container IPv6 → Allow Internet
resource "opnsense_firewall_filter" "ContainerToInternetIpv6" {
  enabled     = true
  sequence    = 42
  action      = "pass"
  quick       = true
  interface   = ["opt4"]
  direction   = "in"
  ip_protocol = "inet6"
  protocol    = "any"

  source = {
    net = "opt4"
  }

  destination = {
    net = "any"
  }

  description = "Allow Container IPv6 to Internet"
}

# ============================================
# 방화벽 규칙 - DMZ VLAN (192.168.5.0/24)
# ============================================

# DMZ → OPNsense Web UI
resource "opnsense_firewall_filter" "DmzToOpnsense" {
  enabled     = true
  sequence    = 50
  action      = "pass"
  quick       = true
  interface   = ["opt5"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "TCP"

  source = {
    net = "opt5"
  }

  destination = {
    net  = "192.168.0.1/32"
    port = "80"
  }

  description = "Allow DMZ to OPNsense Web UI"
}

# DMZ → Proxmox Web UI
resource "opnsense_firewall_filter" "DmzToProxmox" {
  enabled     = true
  sequence    = 51
  action      = "pass"
  quick       = true
  interface   = ["opt5"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "TCP"

  source = {
    net = "opt5"
  }

  destination = {
    net  = "192.168.0.2/32"
    port = "8006"
  }

  description = "Allow DMZ to Proxmox Web UI"
}

# DMZ → Technitium DNS #1
resource "opnsense_firewall_filter" "DmzToDns1" {
  enabled     = true
  sequence    = 52
  action      = "pass"
  quick       = true
  interface   = ["opt5"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "TCP"

  source = {
    net = "opt5"
  }

  destination = {
    net  = "192.168.2.2/32"
    port = "5380"
  }

  description = "Allow DMZ to Technitium DNS #1"
}

# DMZ → Technitium DNS #2
resource "opnsense_firewall_filter" "DmzToDns2" {
  enabled     = true
  sequence    = 53
  action      = "pass"
  quick       = true
  interface   = ["opt5"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "TCP"

  source = {
    net = "opt5"
  }

  destination = {
    net  = "192.168.2.3/32"
    port = "5380"
  }

  description = "Allow DMZ to Technitium DNS #2"
}

# DMZ → TrueNAS
resource "opnsense_firewall_filter" "DmzToTruenas" {
  enabled     = true
  sequence    = 54
  action      = "pass"
  quick       = true
  interface   = ["opt5"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "TCP"

  source = {
    net = "opt5"
  }

  destination = {
    net  = "192.168.2.10/32"
    port = "80"
  }

  description = "Allow DMZ to TrueNAS"
}

# DMZ → PostgreSQL HAProxy
resource "opnsense_firewall_filter" "DmzToPostgresql" {
  enabled     = true
  sequence    = 55
  action      = "pass"
  quick       = true
  interface   = ["opt5"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "TCP"

  source = {
    net = "opt5"
  }

  destination = {
    net  = "192.168.2.30/32"
    port = "5432"
  }

  description = "Allow DMZ to PostgreSQL HAProxy"
}

# DMZ → Gitea
resource "opnsense_firewall_filter" "DmzToGitea" {
  enabled     = true
  sequence    = 56
  action      = "pass"
  quick       = true
  interface   = ["opt5"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "TCP"

  source = {
    net = "opt5"
  }

  destination = {
    net  = "192.168.2.70/32"
    port = "3000"
  }

  description = "Allow DMZ to Gitea"
}

# DMZ → Portainer
resource "opnsense_firewall_filter" "DmzToPortainer" {
  enabled     = true
  sequence    = 57
  action      = "pass"
  quick       = true
  interface   = ["opt5"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "TCP"

  source = {
    net = "opt5"
  }

  destination = {
    net  = "192.168.4.2/32"
    port = "9000"
  }

  description = "Allow DMZ to Portainer"
}

# DMZ → Glance
resource "opnsense_firewall_filter" "DmzToGlance" {
  enabled     = true
  sequence    = 58
  action      = "pass"
  quick       = true
  interface   = ["opt5"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "TCP"

  source = {
    net = "opt5"
  }

  destination = {
    net  = "192.168.4.3/32"
    port = "8080"
  }

  description = "Allow DMZ to Glance"
}

# DMZ → Block remaining internal networks
resource "opnsense_firewall_filter" "DmzBlockInternal" {
  enabled     = true
  sequence    = 59
  action      = "block"
  quick       = true
  interface   = ["opt5"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "any"

  source = {
    net = "opt5"
  }

  destination = {
    net = "192.168.0.0/16"
  }

  description = "Block DMZ access to remaining internal networks"
}

# DMZ → Allow Internet
resource "opnsense_firewall_filter" "DmzToInternet" {
  enabled     = true
  sequence    = 60
  action      = "pass"
  quick       = true
  interface   = ["opt5"]
  direction   = "in"
  ip_protocol = "inet"
  protocol    = "any"

  source = {
    net = "opt5"
  }

  destination = {
    net = "any"
  }

  description = "Allow DMZ to Internet"
}

# DMZ IPv6 → Allow Internet
resource "opnsense_firewall_filter" "DmzToInternetIpv6" {
  enabled     = true
  sequence    = 61
  action      = "pass"
  quick       = true
  interface   = ["opt5"]
  direction   = "in"
  ip_protocol = "inet6"
  protocol    = "any"

  source = {
    net = "opt5"
  }

  destination = {
    net = "any"
  }

  description = "Allow DMZ IPv6 to Internet"
}