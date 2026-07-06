terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.80.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-devopsinsiders"
    storage_account_name = "devopsinsidersstorage24"
    container_name       = "tfstate-dev"
    key                  = "dev.tfstate"
  }
}

provider "azurerm" {
  features {}
}