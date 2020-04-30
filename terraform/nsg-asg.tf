provider "azurerm" {
    version = 1.38
    }

variable "resourcegroup" {
  type = string
  default = "185-3ae6b6-create-azure-nsgs-with-terraform-8w8"
}

variable "location" {
  type = string
  default = "eastus"
}

resource "azurerm_application_security_group" "asg1" {
  name                = "tfASG1"
  location            = var.location
  resource_group_name = var.resourcegroup

  tags = {
    App = "web1"
  }

resource "azurerm_network_security_group" "nsg1" {
  name                = "LabNSG1"
  location            = var.location
  resource_group_name = var.resourcegroup
}

resource "azurerm_network_security_rule" "nsrule1" {
  name                        = "Web80"
  priority                    = 1500
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "80"
  destination_port_range      = "80"
  source_application_security_group_ids = [azurerm_application_security_group.asg1.id]
  destination_address_prefix  = "*"
  resource_group_name         = var.resourcegroup
  network_security_group_name = azurerm_network_security_group.nsg1.name
}

resource "azurerm_network_security_rule" "nsrule2" {
  name                        = "Web8080"
  priority                    = 2000
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "8080"
  destination_port_range      = "8080"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resourcegroup
  network_security_group_name = azurerm_network_security_group.nsg1.name
}

resource "azurerm_network_security_rule" "nsrule3" {
  name                        = "Web80Out"
  priority                    = 1000
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "80"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resourcegroup
  network_security_group_name = azurerm_network_security_group.nsg1.name
}
