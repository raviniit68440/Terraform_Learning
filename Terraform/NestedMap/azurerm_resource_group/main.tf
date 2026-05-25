resource "azurerm_resource_group" "resources" {
  for_each = var.ravirgs

  name       = each.value.name
  location   = each.value.location
  managed_by = each.value.managed_by
}

resource "azurerm_storage_account" "storages" {
  for_each = var.ravistg
  name                     = each.value.name
  resource_group_name      = azurerm_resource_group.resources[each.value.resource_group_key].name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  tags                     = each.value.tags
}