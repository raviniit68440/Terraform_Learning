resource "azurerm_resource_group" "resources" {
for_each = var.common
name = each.key
location=each.value.location

}


resource "azurerm_storage_account" "storages" {
  for_each                 = var.common
  name                     = each.value.name
  resource_group_name      = azurerm_resource_group.resources[each.key].name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  tags                     = each.value.tags
}