module "rg" {
  source          = "../../modules/azurerm_resource_group"
  resource_groups = var.resource_groups
}

module "vnet" {
  depends_on       = [module.rg]
  source           = "../../modules/azurerm_virtual_network"
  virtual_networks = var.virtual_networks
}

module "subnet" {
  depends_on = [module.vnet]
  source     = "../../modules/azurerm_subnet"
  subnets    = var.subnets
}

module "nsg" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_network_security_group"
  nsgs       = var.nsgs
}

module "pips" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_public_ip"
  public_ips = var.public_ips
}

module "storage_accounts" {
  depends_on       = [module.rg]
  source           = "../../modules/azurerm_storage_account"
  storage_accounts = var.storage_accounts
}

module "nic" {
  depends_on = [module.rg, module.subnet]
  source     = "../../modules/azurerm_network_interface"
  nics       = var.nics
}

module "VM" {
  depends_on = [module.rg, module.subnet, module.nic]
  source     = "../../modules/azurerm_virtual_machine"
  vms        = var.vms
}

module "load_balancer" {
  depends_on     = [module.rg, module.pips, module.nic, module.VM]
  source         = "../../modules/azurerm_load_balancer"
  load_balancers = var.load_balancers
}

module "bastions" {
  depends_on = [module.rg, module.subnet, module.pips]
  source     = "../../modules/azurerm_bastion"
  bastions   = var.bastions
}

module "key_vaults" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_key_vault"
  key_vaults = var.key_vaults
}

module "application_gateways" {
  depends_on           = [module.rg, module.subnet, module.pips]
  source               = "../../modules/azurerm_application_gateway"
  application_gateways = var.application_gateways
}
