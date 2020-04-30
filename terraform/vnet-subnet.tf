provider "azurerm" {
    version = 1.38
    }


variable "resourcegroup" {
  type = string
  default = "155-6bb0eb-deploy-azure-vlans-and-subnets-with-ter"
}

variable "location" {
  type = string
  default = "eastus"
}

# Create virtual network
resource "azurerm_virtual_network" "tfVNet" {
    name                = "LabVnet1"
    address_space       = ["10.0.0.0/20"]
    location            = var.location
    resource_group_name = var.resourcegroup

    tags = {
        environment = "TFNetworking"
    }
}

# Create subnet
resource "azurerm_subnet" "tfsubnet" {
    name                 = "LabSubnet1"
    resource_group_name = var.resourcegroup
    virtual_network_name = azurerm_virtual_network.tfVNet.name
    address_prefix       = "10.0.1.0/24"
}
resource "azurerm_subnet" "tfsubnet2" {
    name                 = "LabSubnet2"
    resource_group_name = var.resourcegroup
    virtual_network_name = azurerm_virtual_network.tfVNet.name
    address_prefix       = "10.0.2.0/24"
}
