resource "azurerm_resource_group" "rgs" {
  for_each = var.resource_group
  name     = each.key
  location = each.value.location
}



resource "azurerm_storage_account" "stgs" {
  for_each = var.resource_group
  name=each.value.storage_account_name
  resource_group_name = azurerm_resource_group.rgs[each.key].name
  location = each.value.location
  account_tier = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}
