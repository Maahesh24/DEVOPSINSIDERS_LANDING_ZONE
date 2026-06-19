resource "azurerm_network_interface" "nic" {
  for_each            = var.vm
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
  for_each            = var.vm
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  size                = each.value.size
  admin_username      = each.value.admin_username

  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  # ✅ Use file() with absolute path to your public key
  admin_ssh_key {
    username   = each.value.admin_username
    public_key = file("/Users/mitalipotdar/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
