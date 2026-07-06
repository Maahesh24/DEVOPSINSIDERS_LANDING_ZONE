variable "vnet_peering" {}

resource "azurerm_virtual_network_peering" "peerings" {
  for_each                  = var.vnet_peering
  name                      = each.value.name
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = each.value.virtual_network_name
  remote_virtual_network_id = each.value.remote_virtual_network_id

  allow_forwarded_traffic      = each.value.allow_forwarded_traffic
  allow_virtual_network_access = each.value.allow_virtual_network_access
}
