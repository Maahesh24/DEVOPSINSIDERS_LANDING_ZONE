#################################################
# Resource Group
#################################################

resource "azurerm_resource_group" "rg" {
  for_each = var.rg

  name     = each.value.Name
  location = each.value.location
}


resource "azurerm_storage_account" "storageaccount" {
  for_each = var.storageaccount

  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}


resource "azurerm_virtual_network" "virtual_network" {
  for_each = var.virtual_network

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
}


resource "azurerm_subnet" "subnet" {

  for_each = var.subnet

  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes

}


resource "azurerm_network_interface" "nic" {

  for_each = var.vm

  name                = "${each.value.name}-nic"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {

  for_each = var.vm

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  size                = each.value.size
  admin_username      = each.value.admin_username

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  admin_ssh_key {
    username   = each.value.admin_username
    public_key = file(each.value.public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku        = "22_04-lts-gen2"
    version    = "latest"
  }
}

resource "azurerm_public_ip" "bastion_pip" {

  for_each = var.bastion

  name                = each.value.public_ip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  allocation_method = "Static"
  sku               = "Standard"
}

resource "azurerm_bastion_host" "bastion" {

  for_each = var.bastion

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = each.value.subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_pip[each.key].id
  }
}


resource "azurerm_virtual_network_peering" "vnet_peering" {

  for_each = var.vnet_peering

  name                      = each.value.name
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = each.value.virtual_network_name
  remote_virtual_network_id = each.value.remote_virtual_network_id

  allow_virtual_network_access = each.value.allow_virtual_network_access
  allow_forwarded_traffic      = each.value.allow_forwarded_traffic
  allow_gateway_transit         = each.value.allow_gateway_transit
  use_remote_gateways           = each.value.use_remote_gateways
}