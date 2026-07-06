resource "azurerm_virtual_network_peering" "vmpeering" {
  for_each=var.vnet_peering
  name                      = each.key
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = each.value.source
  remote_virtual_network_id = var.vnet_ids[each.value.target]
}

# ##Bhai badhiya! 😄 Chalo ab isko conceptually samajhte hain. Terraform me **output block** bahut important concept hai, especially jab modules use karte ho.

# ---

# # Pehle samjho problem kya thi

# Maan lo tumhare paas Virtual Network module hai.

# ```text
# Root Module
# │
# ├── Resource Group Module
# ├── VNet Module
# ├── Subnet Module
# └── Peering Module
# ```

# VNet module VNet create karta hai.

# Peering module ko **Remote VNet ki ID** chahiye.

# Lekin problem ye hai ki...

# **Peering module ko pata hi nahi hai VNet module ne kya create kiya.**

# Modules ek dusre se directly baat nahi karte.

# Isliye Terraform ne **Output** ka concept diya.

# ---

# # Real life example

# Maan lo 2 employees hain.

# 👨 Ravi

# 👨 Gautam

# Ravi ke paas ek file hai.

# Gautam ko wo file chahiye.

# Lekin dono direct connect nahi hain.

# Beech me manager hai.

# ```
# Ravi -----> Manager -------> Gautam
# ```

# Manager hi file pass karega.

# Terraform me bhi exactly yehi hota hai.

# ```
# VNet Module -----> Root Module -----> Peering Module
# ```

# Root module manager hai.

# ---

# # Step 1

# VNet module VNet create karta hai.

# ```hcl
# resource "azurerm_virtual_network" "vnets" {
#     for_each = var.vnets

#     name = each.key
# }
# ```

# Suppose do VNets ban gaye.

# ```
# vnetgautam001

# ID:
# /subscriptions/.../vnetgautam001

# ------------------------

# vnetgautam002

# ID:
# /subscriptions/.../vnetgautam002
# ```

# Ye IDs module ke andar hi hain.

# Bahar koi access nahi kar sakta.

# ---

# # Step 2

# Output block

# ```hcl
# output "vnet_ids" {
#   value = {
#     for k,v in azurerm_virtual_network.vnets : k => v.id
#   }
# }
# ```

# Iska matlab kya hua?

# Terraform bol raha hai

# > "Main module ke bahar ye value expose kar raha hu."

# Jaise function return karta hai.

# C language ya Java me

# ```java
# int add(){
#    return 5;
# }
# ```

# Terraform me

# ```hcl
# output "vnet_ids" {
#    value = ...
# }
# ```

# Ye bhi return hi hai.

# ---

# # Ye for loop kya kar raha hai?

# Suppose

# ```
# azurerm_virtual_network.vnets
# ```

# me ye data hai

# ```
# vnetgautam001

# id = xyz111

# -------------------

# vnetgautam002

# id = xyz222
# ```

# for loop

# ```hcl
# for k,v in azurerm_virtual_network.vnets
# ```

# Iteration 1

# ```
# k = vnetgautam001

# v.id = xyz111
# ```

# Iteration 2

# ```
# k = vnetgautam002

# v.id = xyz222
# ```

# Output ban gaya

# ```hcl
# {
#   vnetgautam001 = "xyz111"

#   vnetgautam002 = "xyz222"
# }
# ```

# Ye ek **Map** hai.

# ---

# # Step 3

# Ab Root module ne ye receive kiya.

# ```hcl
# module.azurerm_virtual_network.vnet_ids
# ```

# Yaani

# ```
# module
#       ↓

# azurerm_virtual_network
#       ↓

# output

# vnet_ids
# ```

# Result

# ```hcl
# {
#   vnetgautam001 = "xyz111"

#   vnetgautam002 = "xyz222"
# }
# ```

# ---

# # Step 4

# Ab Root module ye map peering module ko de raha hai.

# ```hcl
# module "azurerm_virtual_network_peering" {

#    vnet_ids = module.azurerm_virtual_network.vnet_ids
# }
# ```

# Yaani

# ```
# VNet Module

# ↓

# Output

# ↓

# Root Module

# ↓

# Peering Module
# ```

# ---

# # Step 5

# Peering module me variable tha

# ```hcl
# variable "vnet_ids" {
#     type = map(string)
# }
# ```

# Ab

# ```
# var.vnet_ids
# ```

# ki value ho gayi

# ```hcl
# {
#   vnetgautam001 = "xyz111"

#   vnetgautam002 = "xyz222"
# }
# ```

# ---

# # Step 6

# Ab tfvars me tha

# ```hcl
# peer1to2 = {

#     source = "vnetgautam001"

#     target = "vnetgautam002"

# }
# ```

# Tumne likha

# ```hcl
# remote_virtual_network_id =
# var.vnet_ids[each.value.target]
# ```

# Ab

# ```
# each.value.target

# =

# vnetgautam002
# ```

# To Terraform karega

# ```hcl
# var.vnet_ids["vnetgautam002"]
# ```

# Map me search karega

# ```
# {
#  vnetgautam001 = xyz111

#  vnetgautam002 = xyz222
# }
# ```

# Answer

# ```
# xyz222
# ```

# Aur wahi ID

# ```
# remote_virtual_network_id
# ```

# me chali jayegi.

# ---

# # Pura Data Flow

# ```text
#                tfvars
#                   │
#                   ▼
#         Virtual Network Module
#                   │
#       azurerm_virtual_network
#                   │
#                   ▼
#              output "vnet_ids"
#                   │
#                   ▼
#  module.azurerm_virtual_network.vnet_ids
#                   │
#                   ▼
#              Root Module
#                   │
#      vnet_ids = module.azurerm_virtual_network.vnet_ids
#                   │
#                   ▼
#             Peering Module
#                   │
#           var.vnet_ids
#                   │
#                   ▼
# var.vnet_ids[each.value.target]
#                   │
#                   ▼
# remote_virtual_network_id
# ```

# ---

# ## Yaad rakhne wali ek line

# * **Variable (`variable`)** = Module ke **andar data bhejna** (input).
# * **Output (`output`)** = Module ke **bahar data nikalna** (return value).

# Agar tum programming jaante ho, to `output` ko **function ke `return`** ki tarah samjho. Ye analogy Terraform modules ko samajhne ka sabse aasan tareeka hai.
# ##