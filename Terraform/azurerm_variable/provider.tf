terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.70.0"
    }
  }
  backend "azurerm" {
    # resource_group_name = "b18g94Common"
    storage_account_name = "b18g94storage"
    container_name = "b18g94container"
    key = "b18g94.tfstate"
    
  }
}

provider "azurerm" {
  features{}
}