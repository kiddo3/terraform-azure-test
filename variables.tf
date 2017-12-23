terraform{
  required_version = "> 0.11.0"
  backend "azurerm"{}
} 

provider "azurerm" {
  subscription_id 	= "${var.subscription_id}"
  client_id 		= "${var.client_id}"
  client_secret 	= "${var.client_secret}"
  tenant_id 		= "${var.tenant_id}"
}

variable "subscription_id" {
  description = "Enter Subscription ID for provisioning resources in Azure"
}

variable "client_id" {
  description = "Enter Client ID for Application created in Azure AD"
}

variable "client_secret" {
  description = "Enter Client secret for Application in Azure AD"
}

variable "tenant_id" {
  description = "Enter Tenant ID / Directory ID of your Azure AD. Run Get-AzureSubscription to know your Tenant ID"
}

variable "location" {
  description = "North Europe"
}

variable "storage_account_name" {
  description = "The storage account name"
}

variable "resource_group_name" {
  description = "The resource group name"
}

variable "vnet_cidr" {
  description = "CIDR block for Virtual Network"
}

variable "subnet1_cidr" {
  description = "CIDR block for Subnet within a Virtual Network"
}

variable "vm_username" {
  description = "Enter admin username to SSH into Linux VM"
}

variable "vm_password" {
  description = "Enter admin password to SSH into VM"
}