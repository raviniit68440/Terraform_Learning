terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.70.0"
    }
  }
}

provider "azurerm" {
  features {}
  }

resource "azurerm_resource_group" "RESOURCERG" {
  name     = "resourcerg"
  location = "West Europe"
}



