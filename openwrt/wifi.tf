resource "openwrt_wireless_device" "fiveG" {
  name     = "fiveG"
  type     = "mac80211"
  htmode   = "HE80"
  band     = "5g"
  country  = "KR"
  path     = "platform/soc/18000000.wifi+1"
  disabled = false
}

resource "openwrt_wireless_device" "twoG" {
  name     = "twoG"
  type     = "mac80211"
  htmode   = "HE20"
  band     = "2g"
  country  = "KR"
  path     = "platform/soc/18000000.wifi"
  disabled = false
}

resource "openwrt_wireless_iface" "fiveG" {
  name       = "fiveG_interface"
  device     = openwrt_wireless_device.fiveG.name
  mode       = "ap"
  ssid       = "WIFI"
  encryption = "sae"
  key        = var.openwrt_password
  network    = [openwrt_network_interface.client.name]
  hidden     = false
  isolate    = false
  disabled   = false
}


resource "openwrt_wireless_iface" "twoG" {
  name       = "twoG_interface"
  device     = openwrt_wireless_device.twoG.name
  mode       = "ap"
  ssid       = "WIFI2.4G"
  encryption = "sae"
  key        = var.openwrt_password
  network    = [openwrt_network_interface.hardware.name]
  hidden     = false
  isolate    = false
  disabled   = false
}
