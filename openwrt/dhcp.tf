resource "openwrt_dhcp_dnsmasq" "main" {
  domainneeded      = true
  localise_queries  = true
  rebind_protection = false
  rebind_localhost  = false
  authoritative     = true
  readethers        = true
  leasefile         = "/tmp/dhcp.leases"
  resolvfile        = "/tmp/resolv.conf.d/resolv.conf.auto"
  localservice      = true
}

resource "openwrt_uci_section" "hardware_pool" {
  config = "dhcp"
  type   = "dhcp"
  name   = "hardware"
  options = {
    interface   = openwrt_network_interface.hardware.name
    dhcpv4      = "server"
    start       = 100
    limit       = 150
    leasetime   = "12h"
    ignore      = false
    dhcp_option = "6,1.1.1.1,1.0.0.1"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}

resource "openwrt_uci_section" "client_pool" {
  config = "dhcp"
  type   = "dhcp"
  name   = "client"
  options = {
    interface   = openwrt_network_interface.client.name
    dhcpv4      = "server"
    start       = 100
    limit       = 150
    leasetime   = "12h"
    ignore      = false
    dhcp_option = "6,1.1.1.1,1.0.0.1"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}

resource "openwrt_uci_section" "service_pool" {
  config = "dhcp"
  type   = "dhcp"
  name   = "service"
  options = {
    interface   = openwrt_network_interface.service.name
    dhcpv4      = "server"
    start       = 100
    limit       = 150
    leasetime   = "12h"
    ignore      = false
    dhcp_option = "6,1.1.1.1,1.0.0.1"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}

resource "openwrt_uci_section" "kubernetes_pool" {
  config = "dhcp"
  type   = "dhcp"
  name   = "kubernetes"
  options = {
    interface   = openwrt_network_interface.kubernetes.name
    dhcpv4      = "server"
    start       = 100
    limit       = 150
    leasetime   = "12h"
    ignore      = false
    dhcp_option = "6,1.1.1.1,1.0.0.1"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}

resource "openwrt_uci_section" "container_pool" {
  config = "dhcp"
  type   = "dhcp"
  name   = "container"
  options = {
    interface   = openwrt_network_interface.container.name
    dhcpv4      = "server"
    start       = 100
    limit       = 150
    leasetime   = "12h"
    ignore      = false
    dhcp_option = "6,1.1.1.1,1.0.0.1"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}


resource "openwrt_uci_section" "dmz_pool" {
  config = "dhcp"
  type   = "dhcp"
  name   = "dmz"
  options = {
    interface   = openwrt_network_interface.dmz.name
    dhcpv4      = "server"
    start       = 100
    limit       = 150
    leasetime   = "12h"
    ignore      = false
    dhcp_option = "6,1.1.1.1,1.0.0.1"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}

