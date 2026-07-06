rgs = {
  rggautam001 = {
    location = "eastasia"
  }
  rggautam002 = {
    location = "centralindia"
  }
}

vnets = {
  vnetgautam001 = {
    location            = "eastasia"
    resource_group_name = "rggautam001"
    address_space       = ["10.0.0.0/16"]
  }

  vnetgautam002 = {
    location            = "centralindia"
    resource_group_name = "rggautam002"
    address_space       = ["10.1.0.0/16"]
  }
}

subnets = {
  subnetgautam001 = {
    resource_group_name  = "rggautam001"
    virtual_network_name = "vnetgautam001"
    address_prefixes     = ["10.0.1.0/24"]
    delegation_name      = "delegation1"
    service_name         = "Microsoft.ContainerInstance/containerGroups"
    actions = [
      "Microsoft.Network/virtualNetworks/subnets/join/action",
      "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
    ]
  }

  subnetgautam002 = {
    resource_group_name  = "rggautam002"
    virtual_network_name = "vnetgautam002"
    address_prefixes     = ["10.1.1.0/24"]
    delegation_name      = "delegation2"
    service_name         = "Microsoft.ContainerInstance/containerGroups"
    actions = [
      "Microsoft.Network/virtualNetworks/subnets/join/action",
      "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
    ]
  }
}

vnet_peering = {
  peer1to2 = {
    resource_group_name = "rggautam001"
    source              = "vnetgautam001"
    target              = "vnetgautam002"
  }
  peer2to1 = {
    resource_group_name = "rggautam002"
    source              = "vnetgautam002"
    target              = "vnetgautam001"
  }
}

stgs = {
  storagegautam01 = {
    resource_group_name      = "rggautam001"
    location                 = "eastasia"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }
}