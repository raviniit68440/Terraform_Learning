resource "azurerm_resource_group" "resources" {
  name       = "rg1"
  location   = "eastus"
}

resource "azurerm_virtual_network" "virtualnetwork" {
  for_each = var.vnets

  name                = each.key
  location            = azurerm_resource_group.resources.location
  resource_group_name = azurerm_resource_group.resources.name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
}