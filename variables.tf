variable "rg" {
  description = "Resource Group details"

  type = map(object({
    Name     = string
    location = string
  }))
}


variable "storageaccount" {
  description = "Storage Account Configuration"

  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
  }))
}


variable "virtual_network" {
  description = "Virtual Network Configuration"

  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
  }))
}


variable "subnet" {
  description = "Subnet Configuration"

  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}



variable "vm" {

  description = "Linux Virtual Machine Configuration"

  type = map(object({

    name                = string
    location            = string
    resource_group_name = string
    subnet_id           = string

    size           = string
    admin_username = string

    public_key_path = string

  }))
}


variable "bastion" {

  description = "Azure Bastion Configuration"

  type = map(object({

    name                = string
    public_ip_name      = string
    location            = string
    resource_group_name = string
    subnet_id           = string

  }))
}



variable "vnet_peering" {

  description = "Virtual Network Peering Configuration"

  type = map(object({

    name                      = string
    resource_group_name       = string
    virtual_network_name      = string
    remote_virtual_network_id = string

    allow_virtual_network_access = bool
    allow_forwarded_traffic      = bool
    allow_gateway_transit        = bool
    use_remote_gateways          = bool

  }))
}