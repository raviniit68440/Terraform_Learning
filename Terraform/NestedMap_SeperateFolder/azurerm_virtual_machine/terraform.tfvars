prefix = "raviNetwork"

location = "eastasia"

vnet_address_space = [ "10.0.0.0/16" ]

subnet_address_prefixes = [ "10.0.1.0/24" ]

admin_username = "devopsinsiders"

admin_password = "DevopsInsiders@123"

image_reference = {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts"
  version   = "latest"
}

virtual_machines = {
"vm1" = {
    vm_name       = "vm-prod-1"
    nic_name      = "nic-prod-1"
    computer_name = "host-prod-1"
    vm_size       = "Standard_D2s_v3"
    environment   = "production"
  },
  "vm2" = {
    vm_name       = "vm-stage-2"
    nic_name      = "nic-stage-2"
    computer_name = "host-stage-2"
    vm_size       = "Standard_D2s_v3"
    environment   = "staging"
  },
  "vm3" = {
    vm_name       = "vm-dev-3"
    nic_name      = "nic-dev-3"
    computer_name = "host-dev-3"
    vm_size       = "Standard_D2s_v3" # Aap har VM ka size bhi alag rakh sakte hain
    environment   = "development"
  }
}