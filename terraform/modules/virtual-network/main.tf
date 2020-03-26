provider "azurerm" {
  version = "=1.44.0"
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "terraform-demo-rg"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
    name     = "tf-vnet"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space = ["192.168.0.0/20"]

    subnet {
        name = "subnet-tfdemo"
        address_space = "192.168.1.0/24"
    }

    tags = {
      environment = "Dev"
  }
}
