terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.76.0"
    }
  }

  # backend "azurerm" {
  #   resource_group_name  = "prod-rg"
  #   storage_account_name = "prodstoracct123"
  #   container_name       = "tfstate"
  #   key                  = "prod.terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
}
