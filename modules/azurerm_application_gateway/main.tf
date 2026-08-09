resource "azurerm_application_gateway" "agw" {
  for_each            = var.application_gateways
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  sku {
    name     = lookup(each.value, "sku_name", "Standard_v2")
    tier     = lookup(each.value, "sku_tier", "Standard_v2")
    capacity = lookup(each.value, "sku_capacity", 2)
  }

  gateway_ip_configuration {
    name      = "agw-ip-config"
    subnet_id = data.azurerm_subnet.agw_subnet[each.key].id
  }

  frontend_port {
    name = "frontend-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ip-config"
    public_ip_address_id = data.azurerm_public_ip.agw_pip[each.key].id
  }

  backend_address_pool {
    name = "backend-pool"
  }

  backend_http_settings {
    name                  = "http-settings"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip-config"
    frontend_port_name             = "frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "http-settings"
    priority                   = 1
  }
}
