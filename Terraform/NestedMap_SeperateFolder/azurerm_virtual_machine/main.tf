resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "internal" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_network_interface" "main" {
  for_each = var.virtual_machines
  name                = "${var.prefix}-${each.value.nic_name}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "ipconfig-${each.key}"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main[each.key].id
  }

}

# Modern and Stable Linux VM Resource
resource "azurerm_linux_virtual_machine" "main" {
  for_each              = var.virtual_machines
  
  name                  = "${var.prefix}-${each.value.vm_name}"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  size                  = each.value.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  disable_password_authentication = false
  
  # Yahan loop key se sahi NIC attach ho raha hai
  network_interface_ids = [
    azurerm_network_interface.main[each.key].id,
  ]

  # Modern OS Disk Configuration
  os_disk {
    name                 = "osdisk-${each.key}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Modern Image Reference
  source_image_reference {
    publisher = var.image_reference.publisher
    offer     = var.image_reference.offer
    sku       = var.image_reference.sku
    version   = var.image_reference.version
  }

  computer_name = each.value.computer_name

  tags = {
    environment = each.value.environment
  }
}

resource "azurerm_public_ip" "main" {
  for_each            = var.virtual_machines
  name                = "${var.prefix}-pip-${each.key}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Dynamic"
}

