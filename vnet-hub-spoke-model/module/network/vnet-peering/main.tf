



  resource "azurerm_virtual_network_peering" "vnet_peer_hub" {
  name                         = "${var.vnet_peering_name_hub}"
  resource_group_name          = "${var.resource_group_name}"
  virtual_network_name         = "${var.virtual_network_name_hub}" 
  remote_virtual_network_id    = "${var.virtual_network_web_vnet_id}"
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}



 resource "azurerm_virtual_network_peering" "vnet_peer_web" {
  name                         = "${var.vnet_peering_name_web}"
  resource_group_name          = "${var.resource_group_name}"
  virtual_network_name         = "${var.virtual_network_name_web}" 
  remote_virtual_network_id    = "${var.virtual_network_hub_vnet_id}"
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
}

