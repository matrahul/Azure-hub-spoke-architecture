# Configure the Azure Provider

provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.3.0"
  features {}

  subscription_id = "${var.subscription_id}"
}

//Call modules  

module "network-rg" {
  source              = "./module/resource-group/network-rg"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
}

module "hub-vnet" {
  source                   = "./module/network/hub-vnet"
  virtual_network_name_hub = "${var.virtual_network_name_hub}"
  vnet_cidr                = "${var.vnet_cidr}"
  resource_group_name      = "${var.resource_group_name}"
  location                 = "${var.location}"
  mgmt_subnet              = "${var.mgmt_subnet}"
  address_prefix_1         = "${var.address_prefix_1}"
  address_prefix_2         = "${var.address_prefix_2}"
  gw_subnet                = "${var.gw_subnet}"
  address_prefix_3         = "${var.address_prefix_3}"
  public_ip_gw             = "${var.public_ip_gw}"
  vnet_gateway             = "${var.vnet_gateway}"
  public_ip_fw             = "${var.public_ip_fw}"
  az_fw                    = "${var.az_fw}"
  vnet_peering_name_hub    = "${var.vnet_peering_name_hub}"
}

module "web-vnet" {
  source                   = "./module/network/web-vnet"
  virtual_network_name_web = "${var.virtual_network_name_web}"
  vnet_cidr_web            = "${var.vnet_cidr_web}"
  resource_group_name      = "${var.resource_group_name}"
  location                 = "${var.location}"
  lb_web_subnet            = "${var.lb_web_subnet}"
  address_prefix_4         = "${var.address_prefix_4}"
  web_subnet               = "${var.web_subnet}"
  address_prefix_5         = "${var.address_prefix_5}"
  vnet_peering_name_web    = "${var.vnet_peering_name_web}"
}

module "database-vnet" {
  source                  = "./module/network/database-vnet"
  virtual_network_name_db = "${var.virtual_network_name_db}"
  vnet_cidr_db            = "${var.vnet_cidr_db}"
  resource_group_name     = "${var.resource_group_name}"
  location                = "${var.location}"
  lb_db_subnet            = "${var.lb_db_subnet}"
  address_prefix_6        = "${var.address_prefix_6}"
  sql_subnet              = "${var.sql_subnet}"
  address_prefix_7        = "${var.address_prefix_7}"
}


module "hubtoweb" {
  source                      = "./module/network/vnet-peering"
  vnet_peering_name_hub       = "var.vnet_peering_name_hub"
  vnet_peering_name_web       = "${var.vnet_peering_name_web}"
  resource_group_name         = "${var.resource_group_name}"
  virtual_network_name_hub    = "${var.virtual_network_name_hub}"
  virtual_network_name_web    = "${var.virtual_network_name_web}"
  virtual_network_web_vnet_id = "${module.web-vnet.web_vnet}"
  virtual_network_hub_vnet_id = "${module.hub-vnet.hub_vnet}"

}


module "webtohub" {
  source                      = "./module/network/vnet-peering"
  vnet_peering_name_web       = "${var.vnet_peering_name_web}"
  vnet_peering_name_hub       = "${var.vnet_peering_name_hub}"
  resource_group_name         = "${var.resource_group_name}"
  virtual_network_name_web    = "${var.virtual_network_name_web}"
  virtual_network_name_hub    = "${var.virtual_network_name_hub}"
  virtual_network_hub_vnet_id = "${module.hub-vnet.hub_vnet}"
  virtual_network_web_vnet_id = "${module.web-vnet.web_vnet}"
}

