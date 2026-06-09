common = {

  stg1 = {
    name                     = "storage1"
    location                 = "eastus"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = {
      environment = "staging"
      owner       = "lun"
    }
  }
  stg2 = {
    name                     = "storage2"
    location                 = "westus"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = {
      environment = "test"
    }
  }
  stg3 = {
    name                     = "storage3"
    location                 = "westeurope"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = {
      environment = "prod"
    }
  }
}