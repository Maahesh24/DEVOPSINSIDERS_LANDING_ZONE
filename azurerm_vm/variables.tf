variable "vm" {
  description = "Map of Virtual Machines"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    size                = string
    admin_username      = string
    ssh_public_key      = string
    subnet_id           = string
  }))
}
