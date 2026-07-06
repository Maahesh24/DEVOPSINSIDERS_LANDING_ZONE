rgs = {
  rg1 = {
    name     = "rg-dhondhu-dev"
    location = "eastus"
  }
}

vnets = {
  vnet1 = {
    name                = "vnet-dhondhu-dev"
    location            = "eastus"
    resource_group_name = "rg-dhondhu-dev"
    address_space       = ["10.0.0.0/16"]
  }
}

snets = {
  snet1 = {
    name                 = "frontend-subnet"
    resource_group_name  = "rg-dhondhu-dev"
    virtual_network_name = "vnet-dhondhu-dev"
    address_prefixes     = ["10.0.1.0/24"]
  }

  snet2 = {
    name                 = "backend"
    resource_group_name  = "rg-dhondhu-dev"
    virtual_network_name = "vnet-dhondhu-dev"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

stg = {
  stg1 = {
    name                     = "stgdhondhudev"
    resource_group_name      = "rg-dhondhu-dev"
    location                 = "eastus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }

  stg2 = {
    name                     = "stgdhondhuprod"
    resource_group_name      = "rg-dhondhu-prod"
    location                 = "westeurope"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }
}

vms = {
  vm1 = {
    name                = "vm-dhondhu-dev"
    location            = "eastus"
    resource_group_name = "rg-dhondhu-dev"
    size                = "Standard_B2s"
    admin_username      = "azureuser"
    subnet_id           = "/subscriptions/<sub-id>/resourceGroups/rg-dhondhu-dev/providers/Microsoft.Network/virtualNetworks/vnet-dhondhu-dev/subnets/frontend-subnet"
  }

  vm2 = {
    name                = "vm-dhondhu-backend"
    location            = "eastus"
    resource_group_name = "rg-dhondhu-dev"
    size                = "Standard_B2s"
    admin_username      = "azureuser"
    subnet_id           = "/subscriptions/<sub-id>/resourceGroups/rg-dhondhu-dev/providers/Microsoft.Network/virtualNetworks/vnet-dhondhu-dev/subnets/backend"
  }
}

bastion = {
  bastion1 = {
    name                = "bastion-prod"
    location            = "eastus"
    resource_group_name = "rg-dhondhu-prod"
    subnet_id           = "/subscriptions/<sub-id>/resourceGroups/rg-dhondhu-prod/providers/Microsoft.Network/virtualNetworks/vnet-dhondhu-prod/subnets/AzureBastionSubnet"
    public_ip_id        = "/subscriptions/<sub-id>/resourceGroups/rg-dhondhu-prod/providers/Microsoft.Network/publicIPAddresses/bastion-prod-ip"
  }

  bastion2 = {
    name                = "bastion-dev"
    location            = "westeurope"
    resource_group_name = "rg-dhondhu-dev"
    subnet_id           = "/subscriptions/<sub-id>/resourceGroups/rg-dhondhu-dev/providers/Microsoft.Network/virtualNetworks/vnet-dhondhu-dev/subnets/AzureBastionSubnet"
    public_ip_id        = "/subscriptions/<sub-id>/resourceGroups/rg-dhondhu-dev/providers/Microsoft.Network/publicIPAddresses/bastion-dev-ip"
  }
}

vnet_peering = {
  dev-to-prod = {
    name                        = "dev-to-prod"
    resource_group_name         = "rg-dhondhu-dev"
    virtual_network_name        = "vnet-dhondhu-dev"
    remote_virtual_network_id   = "/subscriptions/<sub-id>/resourceGroups/rg-dhondhu-prod/providers/Microsoft.Network/virtualNetworks/vnet-dhondhu-prod"
    allow_forwarded_traffic      = true
    allow_virtual_network_access = true
  }

  prod-to-dev = {
    name                        = "prod-to-dev"
    resource_group_name         = "rg-dhondhu-prod"
    virtual_network_name        = "vnet-dhondhu-prod"
    remote_virtual_network_id   = "/subscriptions/<sub-id>/resourceGroups/rg-dhondhu-dev/providers/Microsoft.Network/virtualNetworks/vnet-dhondhu-dev"
    allow_forwarded_traffic      = true
    allow_virtual_network_access = true
  }
}
