resource "azurerm_subnet" "subnets" {
    for_each = var.subnets
  name                 = each.key
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes

  delegation {
    name = each.value.delegation_name

    service_delegation {
      name    = each.value.service_name
      actions = each.value.actions
  }
}
}