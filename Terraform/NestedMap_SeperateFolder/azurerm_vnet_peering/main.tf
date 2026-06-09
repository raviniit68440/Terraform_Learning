resource "azurerm_resource_group" "resource" {
  name     = var.rg
  location = var.location
}

resource "azurerm_virtual_network" "vnetwork" {
  for_each = var.vnet
  name                = each.key
  resource_group_name = azurerm_resource_group.resource.name
  address_space       = each.value.address_space
  location            = azurerm_resource_group.resource.location
}

resource "azurerm_virtual_network_peering" "vmpeering" {
  for_each=var.vnet_peering
  name                      = each.key
  resource_group_name       = azurerm_resource_group.resource.name
  virtual_network_name      = azurerm_virtual_network.vnetwork[each.value.source].name
  remote_virtual_network_id = azurerm_virtual_network.vnetwork[each.value.target].id
}

