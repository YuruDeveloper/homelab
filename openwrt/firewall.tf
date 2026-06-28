resource "openwrt_firewall_zone" "wan" {
  name    = "wan"
  input   = "REJECT"
  output  = "ACCEPT"
  forward = "REJECT"
  masq    = true
  mtu_fix = true
  network = ["wan", "wan6"]
}

resource "openwrt_firewall_zone" "hardware" {
  name    = "hardware"
  input   = "ACCEPT"
  output  = "ACCEPT"
  forward = "ACCEPT"
  network = [openwrt_network_interface.hardware.name]
}

resource "openwrt_firewall_zone" "client" {
  name    = "client"
  input   = "ACCEPT"
  output  = "ACCEPT"
  forward = "ACCEPT"
  network = [openwrt_network_interface.client.name]
}

resource "openwrt_firewall_zone" "service" {
  name    = "service"
  input   = "ACCEPT"
  output  = "ACCEPT"
  forward = "ACCEPT"
  network = [openwrt_network_interface.service.name]
}

resource "openwrt_firewall_zone" "kubernetes" {
  name    = "kubernetes"
  input   = "REJECT"
  output  = "ACCEPT"
  forward = "REJECT"
  network = [openwrt_network_interface.kubernetes.name]
}

resource "openwrt_firewall_zone" "container" {
  name    = "container"
  input   = "REJECT"
  output  = "ACCEPT"
  forward = "REJECT"
  network = [openwrt_network_interface.container.name]
}

resource "openwrt_firewall_zone" "dmz" {
  name    = "dmz"
  input   = "REJECT"
  output  = "ACCEPT"
  forward = "REJECT"
  network = [openwrt_network_interface.dmz.name]
}

resource "openwrt_firewall_zone" "wireguard" {
  name    = "wireguard"
  input   = "ACCEPT"
  output  = "ACCEPT"
  forward = "ACCEPT"
  network = [openwrt_network_interface.wireguard.name]
}


resource "openwrt_firewall_forwarding" "hardware_wan" {
  src  = openwrt_firewall_zone.hardware.name
  dest = openwrt_firewall_zone.wan.name
}

resource "openwrt_firewall_forwarding" "client_wan" {
  src  = openwrt_firewall_zone.client.name
  dest = openwrt_firewall_zone.wan.name
}

resource "openwrt_firewall_forwarding" "client_hardware" {
  src  = openwrt_firewall_zone.client.name
  dest = openwrt_firewall_zone.hardware.name
}

resource "openwrt_firewall_forwarding" "client_service" {
  src  = openwrt_firewall_zone.client.name
  dest = openwrt_firewall_zone.service.name
}

resource "openwrt_firewall_forwarding" "client_kubernets" {
  src  = openwrt_firewall_zone.client.name
  dest = openwrt_firewall_zone.kubernetes.name
}

resource "openwrt_firewall_forwarding" "client_container" {
  src  = openwrt_firewall_zone.client.name
  dest = openwrt_firewall_zone.container.name
}

resource "openwrt_firewall_forwarding" "client_dmz" {
  src  = openwrt_firewall_zone.client.name
  dest = openwrt_firewall_zone.dmz.name
}

resource "openwrt_firewall_forwarding" "service_wan" {
  src  = openwrt_firewall_zone.service.name
  dest = openwrt_firewall_zone.wan.name
}
resource "openwrt_firewall_forwarding" "kubernetes_wan" {
  src  = openwrt_firewall_zone.kubernetes.name
  dest = openwrt_firewall_zone.wan.name
}

resource "openwrt_firewall_forwarding" "container_wan" {
  src  = openwrt_firewall_zone.container.name
  dest = openwrt_firewall_zone.wan.name
}

resource "openwrt_firewall_forwarding" "dmz_wan" {
  src  = openwrt_firewall_zone.dmz.name
  dest = openwrt_firewall_zone.wan.name
}

resource "openwrt_firewall_forwarding" "wireguard_wan" {
  src  = openwrt_network_interface.wireguard.name
  dest = openwrt_firewall_zone.wan.name
}

resource "openwrt_firewall_forwarding" "wireguard_hardware" {
  src  = openwrt_network_interface.wireguard.name
  dest = openwrt_firewall_zone.hardware.name
}

resource "openwrt_firewall_forwarding" "wireguard_client" {
  src  = openwrt_network_interface.wireguard.name
  dest = openwrt_firewall_zone.client.name
}


resource "openwrt_firewall_forwarding" "wireguard_service" {
  src  = openwrt_network_interface.wireguard.name
  dest = openwrt_firewall_zone.service.name
}

resource "openwrt_firewall_forwarding" "wireguard_kubernets" {
  src  = openwrt_network_interface.wireguard.name
  dest = openwrt_firewall_zone.kubernetes.name
}

resource "openwrt_firewall_forwarding" "wireguard_container" {
  src  = openwrt_network_interface.wireguard.name
  dest = openwrt_firewall_zone.container.name
}

resource "openwrt_firewall_forwarding" "wireguard_dmz" {
  src  = openwrt_network_interface.wireguard.name
  dest = openwrt_firewall_zone.dmz.name
}

resource "openwrt_uci_section" "https" {
  config = "firewall"
  type   = "redirect"
  name   = "Https"
  options = {
    name      = "HTTPS to Nginx Reverse Proxy"
    src       = "wan"
    proto     = "tcp"
    src_dport = "443"
    dest      = openwrt_firewall_zone.dmz.name
    dest_ip   = "192.168.5.2"
    dest_port = "443"
    target    = "DNAT"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}

resource "openwrt_uci_section" "http" {
  config = "firewall"
  type   = "redirect"
  name   = "Http"
  options = {
    name      = "HTTP to Nginx Reverse Proxy"
    src       = "wan"
    proto     = "tcp"
    src_dport = "80"
    dest      = openwrt_firewall_zone.dmz.name
    dest_ip   = "192.168.5.2"
    dest_port = "80"
    target    = "DNAT"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}

resource "openwrt_uci_section" "postgresql" {
  config = "firewall"
  type   = "redirect"
  name   = "Postgresql"
  options = {
    name      = "Postgresql to Nginx Reverse Proxy"
    src       = "wan"
    proto     = "tcp"
    src_dport = "5432"
    dest      = openwrt_firewall_zone.dmz.name
    dest_ip   = "192.168.5.2"
    dest_port = "5432"
    target    = "DNAT"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}

resource "openwrt_uci_section" "mongodb" {
  config = "firewall"
  type   = "redirect"
  name   = "MongoDB"
  options = {
    name      = "MongoDB to Nginx Reverse Proxy"
    src       = "wan"
    proto     = "tcp"
    src_dport = "27017"
    dest      = openwrt_firewall_zone.dmz.name
    dest_ip   = "192.168.5.2"
    dest_port = "27017"
    target    = "DNAT"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}

resource "openwrt_uci_section" "valkey" {
  config = "firewall"
  type   = "redirect"
  name   = "Valkey"
  options = {
    name      = "Valkey to Nginx Reverse Proxy"
    src       = "wan"
    proto     = "tcp"
    src_dport = "6379"
    dest      = openwrt_firewall_zone.dmz.name
    dest_ip   = "192.168.5.2"
    dest_port = "6379"
    target    = "DNAT"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}

resource "openwrt_uci_section" "s3" {
  config = "firewall"
  type   = "redirect"
  name   = "S3"
  options = {
    name      = "S3 to Nginx Reverse Proxy"
    src       = "wan"
    proto     = "tcp"
    src_dport = "9000"
    dest      = openwrt_firewall_zone.dmz.name
    dest_ip   = "192.168.5.2"
    dest_port = "9000"
    target    = "DNAT"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}

resource "openwrt_uci_section" "kafka" {
  config = "firewall"
  type   = "redirect"
  name   = "Kafka"
  options = {
    name      = "Kafka to Nginx Reverse Proxy"
    src       = "wan"
    proto     = "tcp"
    src_dport = "9092"
    dest      = openwrt_firewall_zone.dmz.name
    dest_ip   = "192.168.5.2"
    dest_port = "9092"
    target    = "DNAT"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}

resource "openwrt_firewall_rule" "wan_https" {
  name      = "Allow WAN to Nginx HTTPS"
  src       = openwrt_firewall_zone.wan.name
  dest      = openwrt_firewall_zone.dmz.name
  dest_ip   = "192.168.5.2"
  dest_port = "443"
  proto     = "tcp"
  target    = "ACCEPT"
}


resource "openwrt_firewall_rule" "wan_http" {
  name      = "Allow WAN to Nginx HTTP"
  src       = openwrt_firewall_zone.wan.name
  dest      = openwrt_firewall_zone.dmz.name
  dest_ip   = "192.168.5.2"
  dest_port = "80"
  proto     = "tcp"
  target    = "ACCEPT"
}


resource "openwrt_firewall_rule" "wan_postgresql" {
  name      = "Allow WAN to Nginx Postgresql"
  src       = openwrt_firewall_zone.wan.name
  dest      = openwrt_firewall_zone.dmz.name
  dest_ip   = "192.168.5.2"
  dest_port = "5432"
  proto     = "tcp"
  target    = "ACCEPT"
}

resource "openwrt_firewall_rule" "wan_mongodb" {
  name      = "Allow WAN to Nginx MongoDB"
  src       = openwrt_firewall_zone.wan.name
  dest      = openwrt_firewall_zone.dmz.name
  dest_ip   = "192.168.5.2"
  dest_port = "27017"
  proto     = "tcp"
  target    = "ACCEPT"
}


