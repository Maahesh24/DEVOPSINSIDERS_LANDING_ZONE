variable "rgs" {
  description = "Resource group definitions"
  type = map(object({
    name     = string
    location = string
  }))
}

variable "vnets" {
  description = "Virtual network definitions"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
  }))
}

variable "snets" {
  description = "Subnet definitions"
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}

variable "stg" {
  description = "Storage account definitions"
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
  }))
}

variable "vms" {
  description = "Virtual machine definitions"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    subnet_id           = string
    size                = string
    admin_username      = string
  }))
}

variable "bastion" {
  description = "Bastion host definitions"
  type = map(object({
    name                = string
    public_ip_id        = string
    location            = string
    resource_group_name = string
    subnet_id           = string
  }))
}

variable "vnet_peering" {
  description = "VNet peering definitions"
  type = map(object({
    name                         = string
    resource_group_name          = string
    virtual_network_name         = string
    remote_virtual_network_id    = string
    allow_virtual_network_access = bool
    allow_forwarded_traffic      = bool
    allow_gateway_transit        = bool
    use_remote_gateways          = bool
  }))
}
