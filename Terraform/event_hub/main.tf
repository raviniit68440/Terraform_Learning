terraform {
  required_providers{
    azurerm={
      source="hashicorp/azurerm"
      version="4.71.0"
    }
  }
}
provider "azurerm" {
  features{}
}

resource "azurerm_resource_group" "resource" {
    for_each = var.resource_group
  name     = each.key
  location = each.value
}


resource "azurerm_eventhub_namespace" "eventnamespace" {
  name                = var.evenhubname
  location            = azurerm_resource_group.resource["rg1"].location
  resource_group_name = azurerm_resource_group.resource["rg1"].name
  sku                 = "Standard"
  capacity            = 1

  tags = {
    environment = "Production"
  }
}

resource "azurerm_eventhub" "eventhub" {
  name              = var.evenhubname
  namespace_id      = azurerm_eventhub_namespace.eventnamespace.id
  partition_count   = var.partition_count
  message_retention = var.message_retention
}