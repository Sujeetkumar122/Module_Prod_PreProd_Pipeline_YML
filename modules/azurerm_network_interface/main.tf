resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.my-subnet[each.key].id
    public_ip_address_id          = lookup(each.value, "pip_name", null) != null ? data.azurerm_public_ip.my-pip[each.key].id : null
    private_ip_address_allocation = "Dynamic"
  }
}