terraform {                                # Terraform Block: Defines core Terraform settings and requirements for this configuration.
  required_providers {                     # Required Providers Block: Specifies which providers (cloud/services) Terraform needs to interact with.
    azurerm = {                            # Provider configuration (not a block because of '=' assignment): Declares the Azure Resource Manager provider.
      source  = "hashicorp/azurerm"        # Source: Tells Terraform to download the Azure provider plugin from the official HashiCorp registry.
      version = "4.68.0"                   # Version: Locks the provider version to ensure consistency and avoid unexpected changes during future runs.
    }
  } 
} 

# 👉 This block ensures Terraform knows which provider to use, where to get it from, and which version to maintain for stable infrastructure provisioning.


provider "azurerm" {                      # Provider Block: Configures how Terraform will authenticate and interact with Microsoft Azure.
  features{}                              # Features Block: Required for azurerm provider; enables default feature flags and avoids configuration errors.
} 
# 👉 This block initializes and configures the Azure provider so Terraform can create and manage resources in the Azure environment.



resource "azurerm_resource_group" "RGNew" {   # Resource Block: Defines an Azure Resource Group which acts as a logical container for Azure resources.
  name     = "rgnew"                          # Name Argument: Specifies the name of the resource group in Azure.
  location = "West Europe"                   # Location Argument: Defines the Azure region where the resource group will be created.
} 
# 👉 This block creates a resource group in Azure, which is used to organize and manage related resources within a specific region.