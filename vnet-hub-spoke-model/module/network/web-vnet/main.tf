
output "web_vnet" {
  value = azurerm_virtual_network.web_vnet.id
}


output "web_vnet_name" {
  value = azurerm_virtual_network.web_vnet.name
}


resource "azurerm_virtual_network" "web_vnet" {
                 name = "${var.virtual_network_name_web}"
       address_space  = "${var.vnet_cidr_web}"
  resource_group_name = "${var.resource_group_name}"
            location  = "${var.location}"
}
  resource "azurerm_subnet" "lb_web_subnet" {
                     name = "${var.lb_web_subnet}"
      resource_group_name = "${var.resource_group_name}"
     virtual_network_name = "${var.virtual_network_name_web}"
          address_prefix  = "${var.address_prefix_4}"
  }

  resource "azurerm_subnet" "web_subnet" {
       name           = "${var.web_subnet}"
  resource_group_name = "${var.resource_group_name}"
 virtual_network_name = "${var.virtual_network_name_web}"
     address_prefix   = "${var.address_prefix_5}"
  }

 /*
 resource "azurerm_virtual_network_peering" "vnet_peer_web" {
  name                         = "${var.vnet_peering_name_web}"
  resource_group_name          = "${var.resource_group_name}"
  virtual_network_name         = "${var.virtual_network_name_web}" 
  remote_virtual_network_id    = "${data.azurerm_virtual_network.hub_vnet.id}"
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
}
*/