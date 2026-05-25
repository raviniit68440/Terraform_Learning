ravirgs = {
  ravirg1 = {
    name       = "raviresource1"
    location   = "eastus"
    managed_by = "terraform"
  }
  ravirg2 = {
    name       = "raviresource2"
    location   = "westus"
    managed_by = "vscode"
  }
  ravirg3 = {
    name       = "raviresource3"
    location   = "westeurope"
    managed_by = "azcli"
  }
}


ravistg = {
  ravistg1 = {
    name                     = "lhkbnbcbb"
    resource_group_key    = "ravirg1"
    location                 = "eastus"
    account_tier              = "Standard"
    account_replication_type = "GRS"
    tags = {
      environment = "staging"
      owner="lun"
    }
  }
  ravistg2 = {
    name                     = "asdfrgth"
    resource_group_key    = "ravirg2"
    location                 = "westus"
    account_tier              = "Standard"
    account_replication_type = "GRS"
    tags = {
      environment = "test"
    }
  }
  ravistg3 = {
    name                     = "qaswdegs"
    resource_group_key    = "ravirg3"
    location                 = "westeurope"
    account_tier              = "Standard"
    account_replication_type = "GRS"
    tags = {
      environment = "prod"
    }
  }
}