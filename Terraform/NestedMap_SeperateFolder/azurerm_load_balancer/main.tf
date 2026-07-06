# resource group
resource "azurerm_resource_group" "rgs" {
  name     = var.resource_group
  location = var.location
}

# public ip
resource "azurerm_public_ip" "PIP" {
  name                = var.PIP_name
  location            = azurerm_resource_group.rgs.location
  resource_group_name = azurerm_resource_group.rgs.name
  allocation_method   = var.PIP_allowed_method
}

# load baancer - frontend ip config
resource "azurerm_lb" "LB" {
  name                = var.lb_name
  location            = azurerm_resource_group.rgs.location
  resource_group_name = azurerm_resource_group.rgs.name

  frontend_ip_configuration {
    name                 = var.lb_fip_name
    public_ip_address_id = azurerm_public_ip.PIP.id
  }
}

# Backend Address Pool
resource "azurerm_lb_backend_address_pool" "BPOOL" {
  loadbalancer_id = azurerm_lb.LB.id
  name            = var.lbpool_name
}

# Health Probe
resource "azurerm_lb_probe" "HPROBE" {
  loadbalancer_id = azurerm_lb.LB.id
  name            = var.probe_name
  protocol        = var.probe_protocol
  port            = var.probe_port
  request_path    = var.probe_request_path
}

# Load Balancing Rule
resource "azurerm_lb_rule" "LBRULE" {
  loadbalancer_id                = azurerm_lb.LB.id
  name                           = var.lbrule_name
  protocol                       = var.lbrule_protocol
  frontend_port                  = var.lbrule_frontend_port
  backend_port                   = var.lbrule_backend_port
  frontend_ip_configuration_name = var.lbrule_frontend_ip_configuration_name

  backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.BPOOL.id
  ]

  probe_id = azurerm_lb_probe.HPROBE.id
}

# this is for associating the address pool. since i am not making vm in advance so i will not associate it now.
# resource "azurerm_network_interface_backend_address_pool_association" "example" {
#   network_interface_id    = azurerm_network_interface.example.id
#   ip_configuration_name   = "testconfiguration1"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.example.id
# }
