

output "hub_vnet" {
  value = azurerm_virtual_network.hub_vnet.id
}

output "hub_vnet_name" {
  value = azurerm_virtual_network.hub_vnet.name
}


resource "azurerm_virtual_network" "hub_vnet" {
                 name = "${var.virtual_network_name_hub}"
       address_space  = "${var.vnet_cidr}"
  resource_group_name = "${var.resource_group_name}"
            location  = "${var.location}"
}
  resource "azurerm_subnet" "mgmt_subnet" {
                     name = "${var.mgmt_subnet}"
      resource_group_name = "${var.resource_group_name}"
     virtual_network_name = "${var.virtual_network_name_hub}"
          address_prefix  = "${var.address_prefix_1}"

          delegation {
    name = "sql delegation"

    service_delegation {
      actions = [ 
                "Microsoft.Network/virtualNetworks/subnets/join/action",
                "Microsoft.Network/virtualNetworks/subnets/action"
                ]
      name    = "Microsoft.Sql/managedInstances"
    }
  }
  }

  resource "azurerm_subnet" "fw_subnet" {
       name           =  "AzureFirewallSubnet"
  resource_group_name = "${var.resource_group_name}"
 virtual_network_name = "${var.virtual_network_name_hub}"
     address_prefix   = "${var.address_prefix_2}"
  }

output "fw_subnet" {
  value = "azurerm_subnet.fw_subnet.id"
}


 resource "azurerm_public_ip" "public_ip_fw" {
  name                = "${var.public_ip_fw}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  allocation_method   = "Static"
   sku                 = "Standard"
  }

   output "public_ip_fw" {
    value = "azurerm_public_ip.public_ip_fw.id"
  }

resource "azurerm_firewall" "az_fw" {
  name                = "${var.az_fw}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

 ip_configuration {
    name                 = "configuration"
    subnet_id            = "${azurerm_subnet.fw_subnet.id}"
    public_ip_address_id = "${azurerm_public_ip.public_ip_fw.id}"

  }
}

resource "azurerm_subnet" "gw_subnet" {
       name           = "${var.gw_subnet}"
  resource_group_name = "${var.resource_group_name}"
 virtual_network_name = "${var.virtual_network_name_hub}"
     address_prefix   = "${var.address_prefix_3}"
  }

    output "gw_subnet" {
    value = "azurerm_subnet.gw_subnet.id"
  }


   resource "azurerm_public_ip" "public_ip_gw" {
  name                = "${var.public_ip_gw}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  allocation_method   = "Dynamic"
  }

  output "public_ip_gw" {
    value = "azurerm_public_ip.public_ip_gw.id"
  }


resource "azurerm_virtual_network_gateway" "vnet_gateway" {
  name                = "${var.vnet_gateway}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = "Basic"

  ip_configuration {
    public_ip_address_id          = "${azurerm_public_ip.public_ip_gw.id}"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = "${azurerm_subnet.gw_subnet.id}"
  }
}

