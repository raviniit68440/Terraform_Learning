variable "prefix" {
  type        = string
  description = "Resources ka prefix name"
}

variable "location" {
  type        = string
  description = "Azure region jahan resources banengi"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Virtual Network ka IP range"
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "Subnet ka IP range"
}

variable "admin_username" {
  type        = string
  description = "VM ka administrator username"
}

variable "admin_password" {
  type        = string
  sensitive   = true # Isse password logs mein nahi dikhega
  description = "VM ka administrator password"
}

variable "image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "OS Image ki details"
}

# Nested Map for VMs
variable "virtual_machines" {
  type = map(object({
    vm_name       = string
    nic_name      = string
    computer_name = string
    vm_size       = string
    environment   = string
  }))
  description = "Sari VMs ki configuration details"
}