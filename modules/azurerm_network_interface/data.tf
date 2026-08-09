data "azurerm_subnet" "my-subnet" {
  for_each             = var.nics
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "my-pip" {
  for_each            = { for k, v in var.nics : k => v if lookup(v, "pip_name", null) != null }
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}
