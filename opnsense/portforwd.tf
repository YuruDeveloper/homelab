# ============================================
# NAT 포트 포워딩 규칙
# ============================================

# HTTPS (443) → Nginx Reverse Proxy
resource "opnsense_firewall_nat" "HttpsForward" {
  enabled   = true
  interface = "wan"
  protocol  = "TCP"

  source = {
    net = "any"
  }

  destination = {
    net  = "wanip"
    port = "443"
  }

  target = {
    ip   = "192.168.5.2"  # Nginx DMZ
    port = "443"
  }

  description = "HTTPS to Nginx Reverse Proxy"
  log         = false
  sequence    = 1
}

# HTTP (80) → Nginx Reverse Proxy
resource "opnsense_firewall_nat" "HttpForward" {
  enabled   = true
  interface = "wan"
  protocol  = "TCP"

  source = {
    net = "any"
  }

  destination = {
    net  = "wanip"
    port = "80"
  }

  target = {
    ip   = "192.168.5.2"  # Nginx DMZ
    port = "80"
  }

  description = "HTTP to Nginx Reverse Proxy for Lets Encrypt"
  log         = false
  sequence    = 2
}

# PostgreSQL (5432) → Nginx (PostgreSQL Proxy)
resource "opnsense_firewall_nat" "PostgresqlForward" {
  enabled   = true
  interface = "wan"
  protocol  = "TCP"

  source = {
    net = "any"
  }

  destination = {
    net  = "wanip"
    port = "5432"
  }

  target = {
    ip   = "192.168.5.2"  # Nginx DMZ
    port = "5432"
  }

  description = "PostgreSQL external access via Nginx"
  log         = false
  sequence    = 3
}