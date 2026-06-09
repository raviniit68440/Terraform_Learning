resource "azurerm_resource_group" "example" {
  name     = var.aks_basic.rg_name
  location = var.aks_basic.location
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = var.aks_basic.aks_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = var.aks_basic.dns_prefix

  default_node_pool {
    name       = var.aks_basic.node_pool_name
    node_count = var.aks_basic.node_count
    vm_size    = var.aks_basic.vm_size
  }

  identity {
    type = var.aks_basic.type
  }

  tags = {
    Environment = var.aks_basic.environment
  }
}

