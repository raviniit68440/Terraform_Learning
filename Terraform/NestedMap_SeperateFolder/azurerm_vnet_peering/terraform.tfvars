rg = "peeredvnets-rg"
location = "West Europe"

vnet={
   vnetwork1={
    address_space       = ["10.0.1.0/24"]
   } 
   vnetwork2={ 
    address_space       = ["10.0.2.0/24"]
    }
}


vnet_peering = {
    peer1to2={
        source="vnetwork1"
        target="vnetwork2"
        }    
    peer2to1={
         source="vnetwork2"
        target="vnetwork1"
    }
}