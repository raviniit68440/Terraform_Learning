module "azurerm_resource_group" {
  source = "../../child_module/azurerm_resource_group"
  rgs    = var.rgs
}

module "azurerm_virtual_network" {
  source     = "../../child_module/azurerm_virtual_network"
  vnets      = var.vnets
  depends_on = [module.azurerm_resource_group]
}

module "azurerm_subnet" {
  source     = "../../child_module/azurerm_subnet"
  subnets    = var.subnets
  depends_on = [module.azurerm_virtual_network]
}

module "azurerm_storage_account" {
  source = "../../child_module/azurerm_storage_account"
  stgs   = var.stgs
  depends_on = [module.azurerm_resource_group]
}

module "azurerm_virtual_network_peering" {
  source       = "../../child_module/azurerm_vnet_peering"
  vnet_peering = var.vnet_peering
  vnet_ids     = module.azurerm_virtual_network.vnet_ids
  depends_on   = [module.azurerm_virtual_network]
}