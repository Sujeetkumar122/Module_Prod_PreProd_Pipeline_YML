data "azurerm_public_ip" "lb_pip" {
  for_each            = var.load_balancers
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

locals {
  lb_nic_associations = merge([
    for lb_key, lb_val in var.load_balancers : {
      for nic_name in try(lb_val.nic_names, []) :
      "${lb_key}-${nic_name}" => {
        lb_key   = lb_key
        nic_name = nic_name
        rg_name  = lb_val.resource_group_name
      }
    }
  ]...)
}

data "azurerm_network_interface" "lb_nics" {
  for_each            = local.lb_nic_associations
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name
}
