provider "azurerm" {
  version = "~>1.27"
}

variable "resourcegroup" {
  type = string
  default = "terraform-demo-rg"
}

variable "location" {
  type = string
  default = "westeurope"
}

variable "subnetId" {
  type = string
  default = "/subscriptions/71fe3a4a-239d-4df8-8397-4a96c7a09c93/resourceGroups/terraform-demo-rg/providers/Microsoft.Network/virtualNetworks/tf-vnet/subnets/subnet1tf"
}

variable "user" {
  type = string
  default = "tfadmin"
}

variable "password" {
  type = string
  default = "@dM!n@03682be4"
}


module "compute" {
  source  = "Azure/compute/azurerm"
  version = "1.3.0"
  location = var.location
  resource_group_name = var.resourcegroup
  admin_username = var.user
  admin_password = var.password
  vm_size = "Standard_DS2_v2"
  nb_instances = 1
  nb_public_ip = 1
  public_ip_dns = ["tfrhelpip"]
  remote_port = 22
  vm_os_offer = "RHEL"
  vm_os_publisher = "RedHat"
  vm_os_sku = 8
  vm_os_version = "latest"
  vm_hostname = "tfrheldemovm"
  vnet_subnet_id = var.subnetId
  boot_diagnostics = "true"
  delete_os_disk_on_termination = "true"
  data_disk = "true"
  data_disk_size_gb = "512"
  data_sa_type = "StandardSSD_LRS"
  enable_accelerated_networking = false

  tags = {
      environment = "dev"
      costcenter  = "it9792"
    }
}