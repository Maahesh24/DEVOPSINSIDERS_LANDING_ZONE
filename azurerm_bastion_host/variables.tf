variable "vnet_peering" {
  description = "Map of VNet Peerings"
  type = map(object({
    name                      = string
    resource_group_name       = string
    virtual_network_name      = string
    remote_virtual_network_id = string
    allow_forwarded_traffic   = bool
    allow_virtual_network_access = bool
  }))
}
