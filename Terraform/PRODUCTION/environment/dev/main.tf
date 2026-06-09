module "resource_group" {
  source              = "../../modules/azurerm_resource_group"
  rgs=var.rgs
}
