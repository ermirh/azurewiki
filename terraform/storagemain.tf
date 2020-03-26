provider "azurerm" {
  version = "=2.0.0"
  features {}
}

# create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "sademorg1603"
  location = "West Europe"
}

# create storage Account
module "storage_account" {
  source    = "./modules/storage-account"

  storageName    = "satfdemo1603"
  rgName    = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}