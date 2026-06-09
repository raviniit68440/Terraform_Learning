resource "azurerm_resource_group" "resourcegroup" {
  name     = var.rg
  location = var.location
}

resource "azurerm_virtual_network" "vnetwork" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
}

resource "azurerm_subnet" "mysubnets" {
    for_each = var.subnet
  name                 = each.key
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.vnetwork.name
  address_prefixes     = each.value.address_prefixes

  delegation {
    name = each.value.delegation_name

    service_delegation {
      name    = each.value.service_delegation_name
      actions = each.value.serviactionsactions
    }
  }
}