resource "azurerm_resource_group" "resource_dev" {
  name     = "rg_dev"
  location = "West Europe"
}

resource "azurerm_resource_group" "resource_test" {
  name     = "rg_test"
  location = "West Europe"
}

resource "azurerm_resource_group" "resource_uat" {
  name     = "rg_test"
  location = "West Europe"
}

resource "azurerm_resource_group" "resource_prod" {
  name     = "rg_prod"
  location = "West Europe"
}