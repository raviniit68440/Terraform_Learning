variable "names"{}

resource "azurerm_resource_group" "rg1" {
    for_each = var.names
  name     = each.key
  location = each.value
}

