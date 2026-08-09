resource "azurerm_storage_account" "sa" {

  for_each = var.storage_accounts

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  account_tier               = lookup(each.value, "account_tier", "Standard")
  account_replication_type   = lookup(each.value, "account_replication_type", "LRS")
  account_kind               = lookup(each.value, "account_kind", lookup(each.value, "kind", "StorageV2"))
  https_traffic_only_enabled = lookup(each.value, "https_traffic_only_enabled", lookup(each.value, "enable_https_traffic_only", true))

}

