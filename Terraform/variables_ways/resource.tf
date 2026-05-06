terraform {
    required_providers {
        azurerm={
            source="hashicorp/azurerm"
            version="4.71.0"
        }
    }
    backend "azurerm" {
        resource_group_name = "b18g94Common"
        storage_account_name = "b18g94storage"
        container_name = "b18g94container"
        key="gautam.tfstate"
    }
}

provider "azurerm"{
    features{}
}


resource "azurerm_resource_group" "RG1"{
    name=var.rg_name1
    location="westeurope"
}

resource "azurerm_resource_group" "RG2"{
    name=var.rg_name2
    location="westeurope"
}