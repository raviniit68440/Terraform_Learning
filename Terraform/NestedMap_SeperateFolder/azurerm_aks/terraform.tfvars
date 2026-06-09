aks_basic = {
    rg_name= "aks_basic_rg_0305"
    location= "eastasia"
    aks_name="aksbasiccluster"
    dns_prefix= "aksbasicdns"
    node_pool_name="default"
    node_count = 1
    vm_size    = "standard_b2s_v2"
    type = "SystemAssigned"
    environment = "Production"
}