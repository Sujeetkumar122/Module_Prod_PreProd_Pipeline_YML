resource_groups = {
  rg1 = {
    name     = "prod-rg"
    location = "Central India"
  }
}

virtual_networks = {
  vnet1 = {
    name                = "prod-vnet"
    location            = "Central India"
    resource_group_name = "prod-rg"
    address_space       = ["10.1.0.0/16"]
  }
}

subnets = {
  subnet1 = {
    name                 = "prod-subnet1"
    resource_group_name  = "prod-rg"
    virtual_network_name = "prod-vnet"
    address_prefixes     = ["10.1.1.0/24"]
  }

  subnet2 = {
    name                 = "prod-subnet2"
    resource_group_name  = "prod-rg"
    virtual_network_name = "prod-vnet"
    address_prefixes     = ["10.1.2.0/24"]
  }

  bastion_subnet = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "prod-rg"
    virtual_network_name = "prod-vnet"
    address_prefixes     = ["10.1.3.0/26"]
  }

  agw_subnet = {
    name                 = "prod-agw-subnet"
    resource_group_name  = "prod-rg"
    virtual_network_name = "prod-vnet"
    address_prefixes     = ["10.1.4.0/24"]
  }
}

public_ips = {
  lb_pip = {
    name                = "prod-lb-pip"
    location            = "Central India"
    resource_group_name = "prod-rg"
    allocation_method   = "Static"
    sku                 = "Standard"
  }

  bastion_pip = {
    name                = "prod-bastion-pip"
    location            = "Central India"
    resource_group_name = "prod-rg"
    allocation_method   = "Static"
    sku                 = "Standard"
  }

  agw_pip = {
    name                = "prod-agw-pip"
    location            = "Central India"
    resource_group_name = "prod-rg"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

nics = {
  nic1 = {
    name                 = "prod-nic1"
    location             = "Central India"
    resource_group_name  = "prod-rg"
    subnet_name          = "prod-subnet1"
    virtual_network_name = "prod-vnet"
  }

  nic2 = {
    name                 = "prod-nic2"
    location             = "Central India"
    resource_group_name  = "prod-rg"
    subnet_name          = "prod-subnet1"
    virtual_network_name = "prod-vnet"
  }
}

vms = {
  vm1 = {
    name                = "prod-vm1"
    location            = "Central India"
    resource_group_name = "prod-rg"
    nic_name            = "prod-nic1"
    size                = "Standard_B2s"
    admin_username      = "azureuser"
    admin_password      = "P@ssw0rd12345!"
  }

  vm2 = {
    name                = "prod-vm2"
    location            = "Central India"
    resource_group_name = "prod-rg"
    nic_name            = "prod-nic2"
    size                = "Standard_B2s"
    admin_username      = "azureuser"
    admin_password      = "P@ssw0rd12345!"
  }
}

nsgs = {
  nsg1 = {
    name                = "prod-nsg"
    location            = "Central India"
    resource_group_name = "prod-rg"
    security_rules = [
      {
        name                       = "Allow-HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-SSH"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

load_balancers = {
  lb1 = {
    name                = "prod-lb"
    location            = "Central India"
    resource_group_name = "prod-rg"
    sku                 = "Standard"
    pip_name            = "prod-lb-pip"
    frontend_ip_name    = "prod-frontend-ip"
    backend_pool_name   = "prod-backend-pool"
    probe_name          = "http-probe"
    probe_port          = 80
    probe_protocol      = "Tcp"
    lb_rule_name        = "http-rule"
    frontend_port       = 80
    backend_port        = 80
    nic_names           = ["prod-nic1", "prod-nic2"]
  }
}

bastions = {
  bastion1 = {
    name                 = "prod-bastion"
    location             = "Central India"
    resource_group_name  = "prod-rg"
    virtual_network_name = "prod-vnet"
    subnet_name          = "AzureBastionSubnet"
    pip_name             = "prod-bastion-pip"
    sku                  = "Basic"
  }
}

storage_accounts = {
  sa1 = {
    name                       = "prodstoracct123"
    location                   = "Central India"
    resource_group_name        = "prod-rg"
    account_tier               = "Standard"
    account_replication_type   = "LRS"
    account_kind               = "StorageV2"
    https_traffic_only_enabled = true
  }
}

key_vaults = {
  kv1 = {
    name                        = "prod-kv-12345"
    location                    = "Central India"
    resource_group_name         = "prod-rg"
    sku_name                    = "standard"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
  }
}

application_gateways = {
  agw1 = {
    name                 = "prod-agw"
    location             = "Central India"
    resource_group_name  = "prod-rg"
    virtual_network_name = "prod-vnet"
    subnet_name          = "prod-agw-subnet"
    pip_name             = "prod-agw-pip"
    sku_name             = "Standard_v2"
    sku_tier             = "Standard_v2"
    sku_capacity         = 2
  }
}
