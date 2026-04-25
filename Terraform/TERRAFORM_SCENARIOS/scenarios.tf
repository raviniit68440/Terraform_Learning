terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"      # Azure provider source from HashiCorp registry
      version = "4.70.0"                 # Version locking for consistency
    }
  }
}

provider "azurerm" {
  features{}                             # Required block for Azure provider
}

resource "azurerm_resource_group" "ScenarioRG" {
    name     = "scenariorg1"             # Resource Group name
    location = "west us"                 # Azure region
}



##################################################################################################
#                                SCENARIO-BASED DOCUMENTATION                                     #
##################################################################################################

# 📌 SCENARIO 1: Added a New Resource in .tf File
# -----------------------------------------------------------------------------------------------
# Terraform detects new resource → creates it
# terraform plan → shows "1 to add"
# terraform apply → creates resource



# 📌 SCENARIO 2: Removed a Resource from .tf File
# -----------------------------------------------------------------------------------------------
# Terraform detects missing resource in config → deletes it
# terraform plan → shows "1 to destroy"
# terraform apply → removes resource



# 📌 SCENARIO 3: Manually Deleted Resource from Azure Portal (WITH REFRESH CONCEPT)
# -----------------------------------------------------------------------------------------------
# Example: Resource Group deleted manually from Azure Portal

# What happens initially:
# - Terraform state file still thinks resource exists
# - Actual infrastructure does NOT have the resource
# - This mismatch is called "DRIFT"

# 🔁 REFRESH CONCEPT:
# Terraform needs to sync state with real infrastructure

# How refresh works:
# - Terraform queries Azure APIs
# - Compares real infrastructure with state file
# - Updates state accordingly

# Commands:
# terraform refresh        # (Deprecated but concept still valid)
# OR
# terraform plan          # (Automatically performs refresh internally)

# After refresh:
# - Terraform realizes resource is missing
# - Plan shows: "1 to add"

# Then:
# terraform apply

# Result:
# - Resource is recreated in Azure
# - State file updated again

# Key Concepts:
# ➤ Refresh = Sync state with real world
# ➤ Terraform does NOT blindly trust state
# ➤ terraform plan already includes refresh internally



# 📌 SCENARIO 4: Manually Updated Resource (Drift)
# -----------------------------------------------------------------------------------------------
# Terraform detects mismatch and corrects it
# terraform plan → shows "~ change"
# terraform apply → enforces desired state



##################################################################################################
#                                     IMPORTANT CONCEPTS                                          #
##################################################################################################

# 1. Desired State → Defined in .tf file
# 2. Current State → Stored in .tfstate
# 3. Drift → Difference between real infra and state/config
# 4. Refresh → Sync state with real infrastructure
# 5. Plan vs Apply → Plan shows changes, Apply executes



##################################################################################################
#                                      INTERVIEW SUMMARY                                          #
##################################################################################################

# ➤ Scenario 1: New resource → Created
# ➤ Scenario 2: Removed resource → Destroyed
# ➤ Scenario 3: Manual delete → Refresh detects → Recreated
# ➤ Scenario 4: Manual update → Drift detected → Corrected

# One-liner:
# Terraform refresh (implicit in plan) ensures state is synced with real infrastructure,
# allowing Terraform to detect drift and take corrective actions.
##################################################################################################

# ---

# # 🔥 Interview Upgrade (Very Important Line)

# If they ask:

# **“What is refresh in Terraform?”**

# 👉 Say this:

# > “Refresh is the process where Terraform syncs its state file with real infrastructure by querying the provider APIs. It is automatically executed during terraform plan.”

# ---

# # ⚠️ Modern Note (Advanced)

# 👉 `terraform refresh` is now **deprecated**
# 👉 But concept is still **very important**

# Use:

# ```bash
# terraform plan
# ```

# ---

# # 🚀 Now You’re at Strong Level

# You can confidently explain:

# * Drift
# * State
# * Refresh
# * Real-world mismatch

# #
