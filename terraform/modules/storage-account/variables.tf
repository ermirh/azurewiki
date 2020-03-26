variable "storageName" {
    type = string
    description = "Name of storage account"
}

variable "rgName" {
    type = string
    description = "Name of resource group"
}

variable "location" {
    type = string
    description = "Azure location of storage account environment"
    default = "westeurope"
}