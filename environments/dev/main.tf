module "resource_group" {
  source = "../../azurerm_resource_group"
  rgs    = var.rgs
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../azurerm_virtual_network"
  vnets      = var.vnets
}

module "subnets" {
  depends_on = [module.virtual_network]
  source     = "../../azurerm_subnet"
  snets      = var.snets
}

module "storage_accounts" {
  depends_on = [
    module.resource_group,
    module.virtual_network
  ]
  source = "../../azurerm_storage_account"
  stg    = var.stg
}

module "virtual_machines" {
  depends_on = [
    module.resource_group,
    module.virtual_network,
    module.subnets
  ]
  source = "../../azurerm_vm"
  vms    = var.vms
}

module "bastion_hosts" {
  depends_on = [
    module.resource_group,
    module.virtual_network,
    module.subnets
    # remove module.public_ip if you don’t have a separate Public IP module
  ]
  source  = "../../azurerm_bastion_host"
  bastion = var.bastion
}
module "vnet_peering" {
  depends_on = [
    module.resource_group,
    module.virtual_network
  ]
  source       = "../../azurerm_vnet_peering"
  vnet_peering = var.vnet_peering
}
