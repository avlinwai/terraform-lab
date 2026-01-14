terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "520-rg"
    storage_account_name = "storageavlin123"
    container_name       = "terraform-state"
    key                  = "jenkins-demo.tfstate"
  }
}

provider "azurerm" {
  features {}
}