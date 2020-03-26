resource "azurerm_storage_account" "satfdemo" {
  name                     = var.storageName
  resource_group_name      = var.rgName
  location                 = var.location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  access_tier              = "Hot"
  identity {
    type = "SystemAssigned"
  }
 

  tags = {
    environment = "dev"
    resource = "storage"
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "reports1603"
  storage_account_name  = azurerm_storage_account.satfdemo.name
  container_access_type = "private"
}

output "saIdentity" {
    description = "The principal Identity Id for the storage account"
    value = azurerm_storage_account.satfdemo.identity.0.principal_id
    sensitive   = true
}