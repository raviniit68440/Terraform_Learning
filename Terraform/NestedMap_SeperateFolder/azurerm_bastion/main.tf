resource "azurerm_resource_group" "rgs" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_virtual_network" "vnets" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rgs.location
  resource_group_name = azurerm_resource_group.rgs.name
}

resource "azurerm_subnet" "subnet" {
  name                 =var.subnet_name
  resource_group_name  = azurerm_resource_group.rgs.name
  virtual_network_name = azurerm_virtual_network.vnets.name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_public_ip" "publi_ip" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.rgs.location
  resource_group_name = azurerm_resource_group.rgs.name
  allocation_method   = var.public_ip_allocation_method
  sku                 =var.public_ip_sku
}

resource "azurerm_bastion_host" "bastion_host" {
  name                = var.bastion_host_name
  location            = azurerm_resource_group.rgs.location
  resource_group_name = azurerm_resource_group.rgs.name

  ip_configuration {
    name                 = var.ip_congiguration_name
    subnet_id            = azurerm_subnet.subnet.id
    public_ip_address_id = azurerm_public_ip.publi_ip.id
  }
}