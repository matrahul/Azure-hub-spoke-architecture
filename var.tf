variable "subscription_id" {
  default = ""
}

variable "resource_group_name" {
  default = "vnet-arch-rg"
}

variable "location" {
  default = "westus"
}

variable "virtual_network_name_hub" {
  default = "hub-vnet"
}

variable "vnet_cidr" {
  default = ["10.1.0.0/20"]
}

variable "mgmt_subnet" {
  default = "mgmt-subnet"
}

variable "gw_subnet" {
  default = "GatewaySubnet"
}

variable "vnet_gateway" {
  default = "az-gateway"
}

variable "address_prefix_1" {
  default = "10.1.0.0/21"
}

variable "address_prefix_2" {
  default = "10.1.14.0/26"
}

variable "address_prefix_3" {
  default = "10.1.12.0/23"
}

variable "virtual_network_name_web" {
  default = "web-vnet"
}

variable "vnet_cidr_web" {
  default = ["10.10.0.0/20"]
}

variable "lb_web_subnet" {
  default = "lb_web_subnet"
}

variable "web_subnet" {
  default = "web-subnet"
}

variable "address_prefix_4" {
  default = "10.10.0.0/21"
}

variable "address_prefix_5" {
  default = "10.10.8.0/22"
}

variable "virtual_network_name_db" {
  default = "db-vnet"
}

variable "vnet_cidr_db" {
  default = ["10.0.0.0/18"]
}

variable "lb_db_subnet" {
  default = "lb-db-subnet"
}

variable "sql_subnet" {
  default = "sql-subnet"
}

variable "address_prefix_6" {
  default = "10.0.0.0/20"
}

variable "address_prefix_7" {
  default = "10.0.16.0/21"
}

variable "public_ip_gw" {
  default = "gateway-ip"
}

variable "public_ip_fw" {
  default = "fw-ip"
}

variable "vnet_peering_name_hub" {
  default = "hub-web-peering"
}

variable "vnet_peering_name_web" {
  default = "web-hub-peering"
}

variable "az_fw" {
  default = "az-firewall"
}

