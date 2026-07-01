resource "openwrt_network_device" "br_lan" {
  name  = "etc_bridge"
  type  = "bridge"
  ports = var.serivce_lan_devices
}

resource "openwrt_network_device" "br_client" {
  name  = "client_bridge"
  type  = "bridge"
  ports = [var.client_lan_device]
}

resource "openwrt_network_bridge_vlan" "vlan1" {
  device = openwrt_network_device.br_lan.name
  vlan   = 1
  ports = {
    for port in var.serivce_lan_devices : port => "u*"
  }
}

# service
resource "openwrt_network_bridge_vlan" "vlan100" {
  device = openwrt_network_device.br_lan.name
  vlan   = 100
  ports = {
    for port in var.serivce_lan_devices : port => "t"
  }
}
# kubernetes
resource "openwrt_network_bridge_vlan" "vlan200" {
  device = openwrt_network_device.br_lan.name
  vlan   = 200
  ports = {
    for port in var.serivce_lan_devices : port => "t"
  }
}
# container
resource "openwrt_network_bridge_vlan" "vlan300" {
  device = openwrt_network_device.br_lan.name
  vlan   = 300
  ports = {
    for port in var.serivce_lan_devices : port => "t"
  }
}
# dmz
resource "openwrt_network_bridge_vlan" "vlan400" {
  device = openwrt_network_device.br_lan.name
  vlan   = 400
  ports = {
    for port in var.serivce_lan_devices : port => "t"
  }
}

resource "openwrt_network_interface" "wan" {
  name   = "wan"
  proto  = "dhcp"
  device = var.wan_device
  auto   = "1"
}

resource "openwrt_network_interface" "hardware" {
  name   = "hardware"
  proto  = "static"
  device = "${openwrt_network_device.br_lan.name}.1"
  ipaddr = ["192.168.0.1/24"]
  auto   = "1"

  depends_on = [openwrt_network_bridge_vlan.vlan1]
}

resource "openwrt_network_interface" "client" {
  name   = "client"
  proto  = "static"
  device = openwrt_network_device.br_client.name
  ipaddr = ["192.168.1.1/24"]
  auto   = "1"
}

resource "openwrt_network_interface" "service" {
  name   = "service"
  proto  = "static"
  device = "${openwrt_network_device.br_lan.name}.100"
  ipaddr = ["192.168.2.1/24"]
  auto   = "1"

  depends_on = [openwrt_network_bridge_vlan.vlan100]
}

resource "openwrt_network_interface" "kubernetes" {
  name   = "kubernetes"
  proto  = "static"
  device = "${openwrt_network_device.br_lan.name}.200"
  ipaddr = ["192.168.3.1/24"]
  auto   = "1"

  depends_on = [openwrt_network_bridge_vlan.vlan200]
}

resource "openwrt_network_interface" "container" {
  name   = "container"
  proto  = "static"
  device = "${openwrt_network_device.br_lan.name}.300"
  ipaddr = ["192.168.4.1/24"]
  auto   = "1"

  depends_on = [openwrt_network_bridge_vlan.vlan300]
}

resource "openwrt_network_interface" "dmz" {
  name   = "dmz"
  proto  = "static"
  device = "${openwrt_network_device.br_lan.name}.400"
  ipaddr = ["192.168.5.1/24"]
  auto   = "1"

  depends_on = [openwrt_network_bridge_vlan.vlan400]
}

resource "openwrt_network_interface" "wireguard" {
  name   = "wireguard"
  proto  = "wireguard"
  auto   = "1"
  ipaddr = ["100.100.0.1/24"]

  lifecycle {
    ignore_changes = [gateway]
  }
}