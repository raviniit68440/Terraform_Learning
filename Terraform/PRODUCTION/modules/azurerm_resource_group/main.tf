resource "azurerm_resource_group" "rg" {
  for_each = var.rgs
  name     = each.key
  location = each.value.location
  managed_by = each.value.managed_by
}