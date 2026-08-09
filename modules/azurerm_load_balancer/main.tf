resource "azurerm_lb" "lb" {
  for_each            = var.load_balancers
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = try(each.value.sku, "Standard")

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_name
    public_ip_address_id = data.azurerm_public_ip.lb_pip[each.key].id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  for_each        = var.load_balancers
  name            = each.value.backend_pool_name
  loadbalancer_id = azurerm_lb.lb[each.key].id
}

resource "azurerm_lb_probe" "probe" {
  for_each        = var.load_balancers
  name            = each.value.probe_name
  loadbalancer_id = azurerm_lb.lb[each.key].id
  port            = try(each.value.probe_port, 80)
  protocol        = try(each.value.probe_protocol, "Tcp")
}

resource "azurerm_lb_rule" "lb_rule" {
  for_each                       = var.load_balancers
  name                           = each.value.lb_rule_name
  loadbalancer_id                = azurerm_lb.lb[each.key].id
  protocol                       = "Tcp"
  frontend_port                  = try(each.value.frontend_port, 80)
  backend_port                   = try(each.value.backend_port, 80)
  frontend_ip_configuration_name = each.value.frontend_ip_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool[each.key].id]
  probe_id                       = azurerm_lb_probe.probe[each.key].id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_assoc" {
  for_each                = local.lb_nic_associations
  network_interface_id    = data.azurerm_network_interface.lb_nics[each.key].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool[each.value.lb_key].id
}
