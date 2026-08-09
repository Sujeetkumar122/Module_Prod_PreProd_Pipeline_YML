data "azurerm_subnet" "agw_subnet" {
  for_each             = var.application_gateways
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "agw_pip" {
  for_each            = var.application_gateways
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}
