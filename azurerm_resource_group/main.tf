resource "azurerm_resource_group" "rg" {
  for_each = var.rg
  name     = each.value.Name
  location = each.value.location

}
