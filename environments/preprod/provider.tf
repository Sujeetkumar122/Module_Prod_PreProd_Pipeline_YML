terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.76.0"
    }
  }

  # backend "azurerm" {
  #   resource_group_name  = "preprod-rg"
  #   storage_account_name = "preprodstoracct123"
  #   container_name       = "tfstate"
  #   key                  = "preprod.terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
}
