
resource "azurerm_virtual_network" "database_vnet" {
                 name = "${var.virtual_network_name_db}"
       address_space  = "${var.vnet_cidr_db}"
  resource_group_name = "${var.resource_group_name}"
            location  = "${var.location}"
}
  resource "azurerm_subnet" "lb_data_subnet" {
                     name = "${var.lb_db_subnet}"
      resource_group_name = "${var.resource_group_name}"
     virtual_network_name = "${var.virtual_network_name_db}"
          address_prefix  = "${var.address_prefix_6}"
  }

  resource "azurerm_subnet" "sql_subnet" {
       name           = "${var.sql_subnet}"
  resource_group_name = "${var.resource_group_name}"
 virtual_network_name = "${var.virtual_network_name_db}"
     address_prefix   = "${var.address_prefix_7}"
  }

 

