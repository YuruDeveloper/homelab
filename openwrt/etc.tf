resource "openwrt_uci_section" "std_desktop" {
  config = "dhcp"
  type   = "host"
  name   = "std_desktop"
  options = {
    mac       = "18:C0:4D:96:AF:B7"
    ip        = "192.168.1.2"
    broadcast = 1
    leasetime = "infinite"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}

resource "openwrt_uci_section" "std_phone" {
  config = "dhcp"
  type   = "host"
  name   = "std_phone"
  options = {
    mac       = "92:2E:48:4D:B7:E8"
    ip        = "192.168.1.3"
    broadcast = 1
    leasetime = "infinite"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}


resource "openwrt_uci_section" "std_tablet" {
  config = "dhcp"
  type   = "host"
  name   = "std_tablet"
  options = {
    mac       = "B2:41:51:EF:5E:45"
    ip        = "192.168.1.4"
    broadcast = 1
    leasetime = "infinite"
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}

resource "openwrt_uci_section" "wol" {
  config = "luci-wol"
  type   = "target"
  name   = "std_desktop"
  options = {
    name      = "std_deskop"
    mac       = "18:C0:4D:96:AF:B7"
    iface     = "client_bridge"
    broadcast = 1
  }

  lifecycle {
    ignore_changes = [options[".anonymous"]]
  }
}

