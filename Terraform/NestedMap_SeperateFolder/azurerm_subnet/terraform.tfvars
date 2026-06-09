rg= "myRG0305"
location="West Europe"
vnet_name = "myVnet0305"
vnet_address_space = ["10.0.0.0/16"]

subnet={
    subnet1={
        address_prefixes     = ["10.0.1.0/24"]
        delegation_name = "delegation"
         service_delegation_name    = "Microsoft.ContainerInstance/containerGroups"
      serviactionsactions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
    subnet2={
        address_prefixes     = ["10.0.2.0/24"]
        delegation_name = "delegation"
         service_delegation_name    = "Microsoft.ContainerInstance/containerGroups"
      serviactionsactions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
}