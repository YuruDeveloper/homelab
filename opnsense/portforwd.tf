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

# MongoDB (27017) → Nginx (MongoDB Proxy)
resource "opnsense_firewall_nat" "MongoDBForward" {
  enabled   = true
  interface = "wan"
  protocol  = "TCP"

  source = {
    net = "any"
  }

  destination = {
    net  = "wanip"
    port = "27017"
  }

  target = {
    ip   = "192.168.5.2"  # Nginx DMZ
    port = "27017"
  }

  description = "MongoDB external access via Nginx port 27017"
  log         = true
  sequence    = 4
}

# S3 API (9000) → Nginx (S3 Proxy)
resource "opnsense_firewall_nat" "S3ApiForward" {
  enabled   = true
  interface = "wan"
  protocol  = "TCP"

  source = {
    net = "any"
  }

  destination = {
    net  = "wanip"
    port = "9000"
  }

  target = {
    ip   = "192.168.5.2"  # Nginx DMZ
    port = "9000"
  }

  description = "S3 API external access via Nginx"
  log         = false
  sequence    = 5
}

# Redis (6379) → Nginx (Redis Proxy)
resource "opnsense_firewall_nat" "RedisForward" {
  enabled   = true
  interface = "wan"
  protocol  = "TCP"

  source = {
    net = "any"
  }

  destination = {
    net  = "wanip"
    port = "6379"
  }

  target = {
    ip   = "192.168.5.2"  # Nginx DMZ
    port = "6379"
  }

  description = "Redis external access via Nginx"
  log         = false
  sequence    = 6
}

# Kafka (9092) → Nginx Reverse Proxy Kafka
resource "opnsense_firewall_nat" "vForward" {
  enabled   = true
  interface = "wan"
  protocol  = "TCP"

  source = {
    net = "any"
  }

  destination = {
    net  = "wanip"
    port = "9092"
  }

  target = {
    ip   = "192.168.5.2"  # Nginx DMZ
    port = "9092"
  }

  description = "Kafka external access via Nginx"
  log         = false
  sequence    = 7
}
