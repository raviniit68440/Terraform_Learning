
terraform {  
  required_providers {                     # Block to define which providers Terraform will use
    azurerm = {                            # Azure Resource Manager provider configuration
      source  = "hashicorp/azurerm"        # Tells Terraform to download provider from HashiCorp registry
      version = "4.70.0"                   # Locks provider version for consistency across environments
    }
  }
}

provider "azurerm" {                       # Provider block to configure Azure access
  features {}                              # Mandatory block for azurerm provider (enables default features)
}

resource "azurerm_resource_group" "RESOURCERG" {   # Resource block to create an Azure Resource Group
  name     = "resourcerg"                          # Name of the resource group in Azure
  location = "West Europe"                         # Azure region where resource group will be created
}


##################################################################################################
#                                      THEORY / EXPLANATION                                       #
##################################################################################################

# 1. What is Terraform?
# Terraform is an Infrastructure as Code (IaC) tool that allows you to define and provision
# infrastructure using declarative configuration files. Instead of manually creating resources
# in a cloud portal, you write code and Terraform creates and manages them.

# 2. Terraform Block
# The 'terraform' block is used to configure Terraform itself.
# It defines required providers and their versions.
# Version locking ensures that the same provider version is used across all environments,
# avoiding unexpected behavior due to version changes.

# 3. Provider
# A provider is a plugin that allows Terraform to interact with external APIs.
# In this case, 'azurerm' provider is used to interact with Microsoft Azure.
# Terraform downloads the provider during 'terraform init'.
# The 'features {}' block is required for Azure provider and enables default configurations.

# 4. Resource
# A resource is the most important component in Terraform.
# It represents an infrastructure object (e.g., VM, storage, resource group).
# Syntax:
# resource "<provider>_<resource_type>" "<local_name>" { ... }

# In this example:
# - Provider: azurerm
# - Resource Type: resource_group
# - Local Name: RESOURCERG

# 5. Azure Resource Group
# A Resource Group in Azure is a logical container that holds related resources.
# Example: Virtual Machines, Storage Accounts, Networks, etc.
# Benefits:
# - Organize resources
# - Manage access control (RBAC)
# - Apply policies
# - Delete all resources together

# 6. Execution Flow
# Step 1: terraform init
#   - Downloads provider plugins
# Step 2: terraform plan
#   - Shows what changes will be made
# Step 3: terraform apply
#   - Creates the resource group in Azure

# 7. State File (Important Concept)
# Terraform maintains a state file (.tfstate) which tracks real infrastructure.
# It maps your configuration to actual resources.
# This file should NOT be committed to Git (use remote backend instead).

# 8. Idempotency
# Terraform ensures idempotency:
# Running the same configuration multiple times will not create duplicate resources.
# It only makes changes when required.

# 9. Best Practices
# - Never commit .terraform folder
# - Never commit .tfstate file
# - Use .gitignore
# - Use remote backend (like Azure Storage or S3) for team environments

# 10. Interview Summary (One-liner)
# This configuration uses Terraform with Azure provider to create a resource group,
# which acts as a logical container for managing Azure resources efficiently.
##################################################################################################


