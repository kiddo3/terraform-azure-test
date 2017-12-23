/* RESOURCE GROUP */
resource "azurerm_resource_group" "terraform_rg" {
  name 		= "${var.resource_group_name}"
  location 	= "${var.location}"
}

/* STORAGE */
resource "azurerm_storage_account" "storage" {
  name 			= "${var.storage_account_name}"
  resource_group_name 	= "${var.resource_group_name}"
  location 		= "${var.location}"
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storage" {
  name 			= "vhds"
  resource_group_name 	= "${var.resource_group_name}"
  storage_account_name 	= "${azurerm_storage_account.storage.name}"
  container_access_type = "private"
}

/* NETWORK */
resource "azurerm_virtual_network" "vnet_1" {
  name 			= "vnet-1"
  address_space 	= ["${var.vnet_cidr}"]
  location 		= "${var.location}"
  resource_group_name   = "${azurerm_resource_group.terraform_rg.name}"
}

resource "azurerm_subnet" "subnet_1" {
  name 			= "subnet-1"
  address_prefix 	= "${var.subnet1_cidr}"
  virtual_network_name 	= "${azurerm_virtual_network.vnet_1.name}"
  resource_group_name 	= "${azurerm_resource_group.terraform_rg.name}"
}