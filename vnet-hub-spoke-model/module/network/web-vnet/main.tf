
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

