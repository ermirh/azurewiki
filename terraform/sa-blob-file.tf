provider "azurerm" {
    version = 1.38
    }

resource "azurerm_storage_account" "lab" {
  name                     = "sakf693nmkdh63jfls"
  resource_group_name      = "183-8dcc62-deploy-an-azure-file-share-with-terrafo"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "lab" {
  name                  = "blobcontainer4lab"
  storage_account_name  = azurerm_storage_account.lab.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "lab" {
  name                   = "TerraformBlob682"
  storage_account_name   = azurerm_storage_account.lab.name
  storage_container_name = azurerm_storage_container.lab.name
  type                   = "Block"
}
resource "azurerm_storage_share" "lab" {
  name                 = "terraformshare8023"  
  storage_account_name = azurerm_storage_account.lab.name
  quota                = 50
}
