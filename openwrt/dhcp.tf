resource "openwrt_dhcp_dnsmasq" "main" {
  domainneeded      = true
  localise_queries  = true
  rebind_protection = true
  rebind_localhost  = true
  authoritative     = true
  readethers        = true
  leasefile         = "/tmp/dhcp.leases"
  resolvfile        = "/tmp/resolv.conf.d/resolv.conf.auto"
  localservice      = true
  server            = ["1.1.1.1", "1.0.0.1"]
}

resource "openwrt_dhcp_pool" "hardware" {
  name      = "hardware"
  interface = openwrt_network_interface.hardware.name
  start     = 100
  limit     = 150
  leasetime = "12h"
  ignore    = false

  depends_on = [openwrt_network_interface.hardware]
}

resource "openwrt_dhcp_pool" "client" {
  name      = "client"
  interface = openwrt_network_interface.client.name
  start     = 100
  limit     = 150
  leasetime = "12h"
  ignore    = false

  depends_on = [openwrt_network_interface.client]
}

resource "openwrt_dhcp_pool" "service" {
  name      = "service"
  interface = openwrt_network_interface.service.name
  start     = 100
  limit     = 150
  leasetime = "12h"
  ignore    = false
}

resource "openwrt_dhcp_pool" "kubernetes" {
  name      = "kubernetes"
  interface = openwrt_network_interface.kubernetes.name
  start     = 100
  limit     = 150
  leasetime = "12h"
  ignore    = false
}

resource "openwrt_dhcp_pool" "container" {
  name      = "container"
  interface = openwrt_network_interface.container.name
  start     = 100
  limit     = 150
  leasetime = "12h"
  ignore    = false
}

resource "openwrt_dhcp_pool" "dmz" {
  name      = "dmz"
  interface = openwrt_network_interface.dmz.name
  start     = 100
  limit     = 150
  leasetime = "12h"
  ignore    = false
}

