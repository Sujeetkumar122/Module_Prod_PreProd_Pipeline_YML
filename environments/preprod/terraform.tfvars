resource_groups = {
  rg1 = {
    name     = "preprod-rg"
    location = "Central India"
  }
}

virtual_networks = {
  vnet1 = {
    name                = "preprod-vnet"
    location            = "Central India"
    resource_group_name = "preprod-rg"
    address_space       = ["10.0.0.0/16"]
  }
}

subnets = {
  subnet1 = {
    name                 = "preprod-subnet1"
    resource_group_name  = "preprod-rg"
    virtual_network_name = "preprod-vnet"
    address_prefixes     = ["10.0.1.0/24"]
  }

  subnet2 = {
    name                 = "preprod-subnet2"
    resource_group_name  = "preprod-rg"
    virtual_network_name = "preprod-vnet"
    address_prefixes     = ["10.0.2.0/24"]
  }

  bastion_subnet = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "preprod-rg"
    virtual_network_name = "preprod-vnet"
    address_prefixes     = ["10.0.3.0/26"]
  }

  agw_subnet = {
    name                 = "preprod-agw-subnet"
    resource_group_name  = "preprod-rg"
    virtual_network_name = "preprod-vnet"
    address_prefixes     = ["10.0.4.0/24"]
  }
}

public_ips = {
  lb_pip = {
    name                = "preprod-lb-pip"
    location            = "Central India"
    resource_group_name = "preprod-rg"
    allocation_method   = "Static"
    sku                 = "Standard"
  }

  bastion_pip = {
    name                = "preprod-bastion-pip"
    location            = "Central India"
    resource_group_name = "preprod-rg"
    allocation_method   = "Static"
    sku                 = "Standard"
  }

  agw_pip = {
    name                = "preprod-agw-pip"
    location            = "Central India"
    resource_group_name = "preprod-rg"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

nics = {
  nic1 = {
    name                 = "preprod-nic1"
    location             = "Central India"
    resource_group_name  = "preprod-rg"
    subnet_name          = "preprod-subnet1"
    virtual_network_name = "preprod-vnet"
  }

  nic2 = {
    name                 = "preprod-nic2"
    location             = "Central India"
    resource_group_name  = "preprod-rg"
    subnet_name          = "preprod-subnet1"
    virtual_network_name = "preprod-vnet"
  }
}

vms = {
  vm1 = {
    name                = "preprod-vm1"
    location            = "Central India"
    resource_group_name = "preprod-rg"
    nic_name            = "preprod-nic1"
    size                = "Standard_B2s"
    admin_username      = "azureuser"
    admin_password      = "P@ssw0rd12345!"
  }

  vm2 = {
    name                = "preprod-vm2"
    location            = "Central India"
    resource_group_name = "preprod-rg"
    nic_name            = "preprod-nic2"
    size                = "Standard_B2s"
    admin_username      = "azureuser"
    admin_password      = "P@ssw0rd12345!"
  }
}

nsgs = {
  nsg1 = {
    name                = "preprod-nsg"
    location            = "Central India"
    resource_group_name = "preprod-rg"
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
    name                = "preprod-lb"
    location            = "Central India"
    resource_group_name = "preprod-rg"
    sku                 = "Standard"
    pip_name            = "preprod-lb-pip"
    frontend_ip_name    = "preprod-frontend-ip"
    backend_pool_name   = "preprod-backend-pool"
    probe_name          = "http-probe"
    probe_port          = 80
    probe_protocol      = "Tcp"
    lb_rule_name        = "http-rule"
    frontend_port       = 80
    backend_port        = 80
    nic_names           = ["preprod-nic1", "preprod-nic2"]
  }
}

bastions = {
  bastion1 = {
    name                 = "preprod-bastion"
    location             = "Central India"
    resource_group_name  = "preprod-rg"
    virtual_network_name = "preprod-vnet"
    subnet_name          = "AzureBastionSubnet"
    pip_name             = "preprod-bastion-pip"
    sku                  = "Basic"
  }
}

storage_accounts = {
  sa1 = {
    name                       = "preprodstoracct123"
    location                   = "Central India"
    resource_group_name        = "preprod-rg"
    account_tier               = "Standard"
    account_replication_type   = "LRS"
    account_kind               = "StorageV2"
    https_traffic_only_enabled = true
  }
}

key_vaults = {
  kv1 = {
    name                        = "preprod-kv-12345"
    location                    = "Central India"
    resource_group_name         = "preprod-rg"
    sku_name                    = "standard"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
  }
}

application_gateways = {
  agw1 = {
    name                 = "preprod-agw"
    location             = "Central India"
    resource_group_name  = "preprod-rg"
    virtual_network_name = "preprod-vnet"
    subnet_name          = "preprod-agw-subnet"
    pip_name             = "preprod-agw-pip"
    sku_name             = "Standard_v2"
    sku_tier             = "Standard_v2"
    sku_capacity         = 2
  }
}
