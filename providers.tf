#IaC on Azure Cloud Platform | Declare Azure as the Provider
# Configure the Microsoft Azure Provider
terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }

  #Configure Remote State - Backend - on Azure Storage Account in a separate location away from resources
  #   backend "azurerm" {
  #     resource_group_name  = "tf-backend-rg"
  #     storage_account_name = "tfbackendstorage2307"
  #     container_name       = "tfbackendcontainer"
  #     key                  = "terraform.tfstate"
  #   }

}

provider "azurerm" {
  features {}
}