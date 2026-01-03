# ============================================
# 방화벽 규칙 - WAN (포트포워딩 허용)
# ============================================

# WAN → Allow HTTPS (443) forwarded traffic
resource "opnsense_firewall_filter" "WanAllowHttps" {
  enabled     = true
  sequence    = 1
  description = "Allow WAN to Nginx HTTPS (NAT forwarded)"

  interface = {
    interface = ["wan"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "any"
    }

    destination = {
      net  = "192.168.5.2/32"
      port = "443"
    }
  }
}

# WAN → Allow HTTP (80) forwarded traffic
resource "opnsense_firewall_filter" "WanAllowHttp" {
  enabled     = true
  sequence    = 2
  description = "Allow WAN to Nginx HTTP (NAT forwarded)"

  interface = {
    interface = ["wan"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "any"
    }

    destination = {
      net  = "192.168.5.2/32"
      port = "80"
    }
  }
}

# WAN → Allow PostgreSQL (5432) forwarded traffic
resource "opnsense_firewall_filter" "WanAllowPostgresql" {
  enabled     = true
  sequence    = 3
  description = "Allow WAN to Nginx PostgreSQL Proxy (NAT forwarded)"

  interface = {
    interface = ["wan"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "any"
    }

    destination = {
      net  = "192.168.5.2/32"
      port = "5432"
    }
  }
}

# WAN → Allow MongoDB (27017) forwarded traffic
resource "opnsense_firewall_filter" "WanAllowMongodb" {
  enabled     = true
  sequence    = 4
  description = "Allow WAN to Nginx MongoDB Proxy port 27017"

  interface = {
    interface = ["wan"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"
    log         = true

    source = {
      net = "any"
    }

    destination = {
      net  = "192.168.5.2/32"
      port = "27017"
    }
  }
}

# WAN → Allow S3 API (9000) forwarded traffic
resource "opnsense_firewall_filter" "WanAllowS3Api" {
  enabled     = true
  sequence    = 5
  description = "Allow WAN to Nginx S3 API Proxy port 9000"

  interface = {
    interface = ["wan"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "any"
    }

    destination = {
      net  = "192.168.5.2/32"
      port = "9000"
    }
  }
}

# WAN → Allow Redis (6379) forwarded traffic
resource "opnsense_firewall_filter" "WanAllowRedis" {
  enabled     = true
  sequence    = 6
  description = "Allow WAN to Nginx Redis Proxy port 6379"

  interface = {
    interface = ["wan"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "any"
    }

    destination = {
      net  = "192.168.5.2/32"
      port = "6379"
    }
  }
}

# ============================================
# 방화벽 규칙 - LAN (Hardware Network)
# ============================================

# LAN - Allow all to any
resource "opnsense_firewall_filter" "LanToAny" {
  enabled     = true
  sequence    = 1
  description = "Default allow LAN to any rule"

  interface = {
    interface = ["lan"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "any"

    source = {
      net = "lan"
    }

    destination = {
      net = "any"
    }
  }
}

# LAN IPv6 - Allow all to any
resource "opnsense_firewall_filter" "LanToAnyIpv6" {
  enabled     = true
  sequence    = 2
  description = "Default allow LAN IPv6 to any rule"

  interface = {
    interface = ["lan"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet6"
    protocol    = "any"

    source = {
      net = "lan"
    }

    destination = {
      net = "any"
    }
  }
}

# ============================================
# 방화벽 규칙 - LAN1 (클라이언트 네트워크)
# ============================================

# LAN1 (192.168.1.0/24) - Allow all to any
resource "opnsense_firewall_filter" "Lan1ToAny" {
  enabled     = true
  sequence    = 10
  description = "Default allow LAN1 to any rule"

  interface = {
    interface = ["opt1"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "any"

    source = {
      net = "192.168.1.0/24"
    }

    destination = {
      net = "any"
    }
  }
}

# LAN1 IPv6 - Allow all to any
resource "opnsense_firewall_filter" "Lan1ToAnyIpv6" {
  enabled     = true
  sequence    = 11
  description = "Default allow LAN1 IPv6 to any rule"

  interface = {
    interface = ["opt1"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet6"
    protocol    = "any"

    source = {
      net = "opt1"
    }

    destination = {
      net = "any"
    }
  }
}

# ============================================
# 방화벽 규칙 - Service VLAN (192.168.2.0/24)
# ============================================

# Service VLAN - Allow all to any
resource "opnsense_firewall_filter" "ServiceToAny" {
  enabled     = true
  sequence    = 20
  description = "Default allow Service VLAN to any rule"

  interface = {
    interface = ["opt2"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "any"

    source = {
      net = "192.168.2.0/24"
    }

    destination = {
      net = "any"
    }
  }
}

# Service VLAN IPv6 - Allow all to any
resource "opnsense_firewall_filter" "ServiceToAnyIpv6" {
  enabled     = true
  sequence    = 21
  description = "Default allow Service VLAN IPv6 to any rule"

  interface = {
    interface = ["opt2"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet6"
    protocol    = "any"

    source = {
      net = "opt2"
    }

    destination = {
      net = "any"
    }
  }
}

# ============================================
# 방화벽 규칙 - Kubernetes VLAN (192.168.3.0/24)
# ============================================

# Kubernetes → Technitium DNS #1
resource "opnsense_firewall_filter" "K8sToDns1" {
  enabled     = true
  sequence    = 30
  description = "Allow Kubernetes to DNS Server #1"

  interface = {
    interface = ["opt3"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "UDP"

    source = {
      net = "192.168.3.0/24"
    }

    destination = {
      net  = "192.168.2.2/32"
      port = "53"
    }
  }
}

# Kubernetes → Technitium DNS #2
resource "opnsense_firewall_filter" "K8sToDns2" {
  enabled     = true
  sequence    = 31
  description = "Allow Kubernetes to DNS Server #2"

  interface = {
    interface = ["opt3"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "UDP"

    source = {
      net = "192.168.3.0/24"
    }

    destination = {
      net  = "192.168.2.3/32"
      port = "53"
    }
  }
}

# Kubernetes → Block internal networks
resource "opnsense_firewall_filter" "K8sBlockInternal" {
  enabled     = true
  sequence    = 32
  description = "Block Kubernetes access to internal networks"

  interface = {
    interface = ["opt3"]
  }

  filter = {
    action      = "block"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "any"

    source = {
      net = "192.168.3.0/24"
    }

    destination = {
      net = "192.168.0.0/16"
    }
  }
}

# Kubernetes → Allow Internet
resource "opnsense_firewall_filter" "K8sToInternet" {
  enabled     = true
  sequence    = 33
  description = "Allow Kubernetes to Internet"

  interface = {
    interface = ["opt3"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "any"

    source = {
      net = "192.168.3.0/24"
    }

    destination = {
      net = "any"
    }
  }
}

# Kubernetes IPv6 → Allow Internet
resource "opnsense_firewall_filter" "K8sToInternetIpv6" {
  enabled     = true
  sequence    = 34
  description = "Allow Kubernetes IPv6 to Internet"

  interface = {
    interface = ["opt3"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet6"
    protocol    = "any"

    source = {
      net = "opt3"
    }

    destination = {
      net = "any"
    }
  }
}

# ============================================
# 방화벽 규칙 - Container VLAN (192.168.4.0/24)
# ============================================

resource "opnsense_firewall_filter" "ContainerToNginx" {
  enabled     = true
  sequence    = 39
  description = "Allow Container to Nginx for NAT reflection"

  interface = {
    interface = ["opt4"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "192.168.4.0/24"
    }

    destination = {
      net  = "192.168.5.2/32"
      port = "443"
    }
  }
}

# Container → Block internal networks
resource "opnsense_firewall_filter" "ContainerBlockInternal" {
  enabled     = true
  sequence    = 42
  description = "Block Container access to internal networks"

  interface = {
    interface = ["opt4"]
  }

  filter = {
    action      = "block"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "any"

    source = {
      net = "192.168.4.0/24"
    }

    destination = {
      net = "192.168.0.0/16"
    }
  }
}

# Container → Allow Internet
resource "opnsense_firewall_filter" "ContainerToInternet" {
  enabled     = true
  sequence    = 43
  description = "Allow Container to Internet"

  interface = {
    interface = ["opt4"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "any"

    source = {
      net = "192.168.4.0/24"
    }

    destination = {
      net = "any"
    }
  }
}

# Container IPv6 → Allow Internet
resource "opnsense_firewall_filter" "ContainerToInternetIpv6" {
  enabled     = true
  sequence    = 44
  description = "Allow Container IPv6 to Internet"

  interface = {
    interface = ["opt4"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet6"
    protocol    = "any"

    source = {
      net = "opt4"
    }

    destination = {
      net = "any"
    }
  }
}

# ============================================
# 방화벽 규칙 - DMZ VLAN (192.168.5.0/24)
# ============================================

# DMZ → OPNsense Web UI
resource "opnsense_firewall_filter" "DmzToOpnsense" {
  enabled     = true
  sequence    = 50
  description = "Allow DMZ to OPNsense Web UI"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net  = "192.168.0.1/32"
      port = "80"
    }
  }
}

# DMZ → Proxmox Web UI
resource "opnsense_firewall_filter" "DmzToProxmox" {
  enabled     = true
  sequence    = 51
  description = "Allow DMZ to Proxmox Web UI"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net  = "192.168.0.2/32"
      port = "8006"
    }
  }
}

# DMZ → Technitium DNS #1
resource "opnsense_firewall_filter" "DmzToDns1" {
  enabled     = true
  sequence    = 52
  description = "Allow DMZ to Technitium DNS #1"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net  = "192.168.2.2/32"
      port = "5380"
    }
  }
}

# DMZ → Technitium DNS #2
resource "opnsense_firewall_filter" "DmzToDns2" {
  enabled     = true
  sequence    = 53
  description = "Allow DMZ to Technitium DNS #2"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net  = "192.168.2.3/32"
      port = "5380"
    }
  }
}

# DMZ → TrueNAS
resource "opnsense_firewall_filter" "DmzToTruenas" {
  enabled     = true
  sequence    = 54
  description = "Allow DMZ to TrueNAS"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net  = "192.168.2.10/32"
      port = "80"
    }
  }
}

# DMZ → PostgreSQL HAProxy
resource "opnsense_firewall_filter" "DmzToPostgresql" {
  enabled     = true
  sequence    = 55
  description = "Allow DMZ to PostgreSQL HAProxy"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net  = "192.168.2.30/32"
      port = "5432"
    }
  }
}

# DMZ → Gitea
resource "opnsense_firewall_filter" "DmzToGitea" {
  enabled     = true
  sequence    = 56
  description = "Allow DMZ to Gitea"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net  = "192.168.2.80/32"
      port = "3000"
    }
  }
}

# DMZ → Portainer
resource "opnsense_firewall_filter" "DmzToPortainer" {
  enabled     = true
  sequence    = 57
  description = "Allow DMZ to Portainer"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net  = "192.168.4.2/32"
      port = "9000"
    }
  }
}

# DMZ → Glance
resource "opnsense_firewall_filter" "DmzToGlance" {
  enabled     = true
  sequence    = 58
  description = "Allow DMZ to Glance"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net  = "192.168.4.3/32"
      port = "8080"
    }
  }
}

# DMZ → RustFS
resource "opnsense_firewall_filter" "DmzToRustfs" {
  enabled     = true
  sequence    = 59
  description = "Allow DMZ to RustFS"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net  = "192.168.2.50/32"
      port = "9000-9001"
    }
  }
}

# DMZ → MongoDB HAProxy
resource "opnsense_firewall_filter" "DmzToMongodb" {
  enabled     = true
  sequence    = 59
  description = "Allow DMZ to MongoDB HAProxy"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net  = "192.168.2.31/32"
      port = "27018"
    }
  }
}

# DMZ → Redis HAProxy
resource "opnsense_firewall_filter" "DmzToRedis" {
  enabled     = true
  sequence    = 60
  description = "Allow DMZ to Redis HAProxy"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net  = "192.168.2.32/32"
      port = "6379"
    }
  }
}

# DMZ → Redpanda
resource "opnsense_firewall_filter" "DmzToRePandaTcp" {
  enabled     = true
  sequence    = 61
  description = "Allow DMZ to Redpanda kafka api"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net  = "192.168.2.90/32"
      port = "9092"
    }
  }
}

# DMZ → Redpanda Rest
resource "opnsense_firewall_filter" "DmzToRePandaRest" {
  enabled     = true
  sequence    = 62
  description = "Allow DMZ to Redpanda kafka rest api"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net  = "192.168.2.90/32"
      port = "8082"
    }
  }
}

# DMZ → Block remaining internal networks
resource "opnsense_firewall_filter" "DmzBlockInternal" {
  enabled     = true
  sequence    = 63
  description = "Block DMZ access to remaining internal networks"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "block"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "any"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net = "192.168.0.0/16"
    }
  }
}

# DMZ → Allow Internet
resource "opnsense_firewall_filter" "DmzToInternet" {
  enabled     = true
  sequence    = 64
  description = "Allow DMZ to Internet"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "any"

    source = {
      net = "192.168.5.0/24"
    }

    destination = {
      net = "any"
    }
  }
}

# DMZ IPv6 → Allow Internet
resource "opnsense_firewall_filter" "DmzToInternetIpv6" {
  enabled     = true
  sequence    = 65
  description = "Allow DMZ IPv6 to Internet"

  interface = {
    interface = ["opt5"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet6"
    protocol    = "any"

    source = {
      net = "opt5"
    }

    destination = {
      net = "any"
    }
  }
}

# ============================================
# 방화벽 규칙 - Wireguard VPN (opt6)
# ============================================

# Wireguard → Allow all to any
resource "opnsense_firewall_filter" "Wireguard" {
  enabled     = true
  sequence    = 66
  description = "Allow Wireguard interface to any"

  interface = {
    interface = ["opt6"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "any"

    source = {
      net = "opt6"
    }

    destination = {
      net = "any"
    }
  }
}

# Wireguard IPv6 → Allow all to any
resource "opnsense_firewall_filter" "WireguardIpv6" {
  enabled     = true
  sequence    = 67
  description = "Allow Wireguard IPv6 interface to any"

  interface = {
    interface = ["opt6"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet6"
    protocol    = "any"

    source = {
      net = "opt6"
    }

    destination = {
      net = "any"
    }
  }
}

# WAN → Allow Wireguard VPN (UDP 51820)
resource "opnsense_firewall_filter" "WanAllowWireguard" {
  enabled     = true
  sequence    = 68
  description = "Allow WAN to Wireguard VPN (UDP 51820)"

  interface = {
    interface = ["wan"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "UDP"

    source = {
      net = "any"
    }

    destination = {
      net  = "any"
      port = "51820"
    }
  }
}

# WAN → Allow Kafka (TCP 9092)
resource "opnsense_firewall_filter" "WanAllowKafka" {
  enabled     = true
  sequence    = 69
  description = "Allow WAN to Kafka (TCP 9092)"

  interface = {
    interface = ["wan"]
  }

  filter = {
    action      = "pass"
    quick       = true
    direction   = "in"
    ip_protocol = "inet"
    protocol    = "TCP"

    source = {
      net = "any"
    }

    destination = {
      net  = "192.168.5.2/32"
      port = "9092"
    }
  }
}