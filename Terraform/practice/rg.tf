terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.70.0"
    }
  }
# backend "azurerm" {
#     resource_group_name = "asg-resource-group"
#     storage_account_name = "asguniquecontainer"                              # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
#     container_name       = "asguniquecontainer"                               # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
#     key                  = "pramod.tfstate"                # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
#   }

}

provider "azurerm" {
  features{}
}

# resource "azurerm_resource_group" "name" {
#     name="rgunique1"
#     location="westeurope"
  
# }

# resource "azurerm_resource_group" "name1" {
#     name="rgunique2"
#     location="westeurope"
  
# }