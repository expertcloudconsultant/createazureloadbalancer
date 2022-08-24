#Create Resource Groups
resource "azurerm_resource_group" "corporate-production-rg" {
  name     = "corporate-production-rg"
  location = var.avzs[0] #Avaialability Zone 0 always marks your Primary Region.
}



#Create Virtual Networks > Create Spoke Virtual Network
resource "azurerm_virtual_network" "corporate-prod-vnet" {
  name                = "corporate-prod-vnet"
  location            = azurerm_resource_group.corporate-production-rg.location
  resource_group_name = azurerm_resource_group.corporate-production-rg.name
  address_space       = ["10.20.0.0/16"]

  tags = {
    environment = "Production Network"
  }
}


#Create Subnet
resource "azurerm_subnet" "business-tier-subnet" {
  name                 = "business-tier-subnet"
  resource_group_name  = azurerm_resource_group.corporate-production-rg.name
  virtual_network_name = azurerm_virtual_network.corporate-prod-vnet.name
  address_prefixes     = ["10.20.10.0/24"]
}

#Create Private Network Interfaces
resource "azurerm_network_interface" "corpnic" {
  name                = "corpnic-${count.index + 1}"
  location            = azurerm_resource_group.corporate-production-rg.location
  resource_group_name = azurerm_resource_group.corporate-production-rg.name
  count               = 2

  ip_configuration {
    name                          = "ipconfig-${count.index + 1}"
    subnet_id                     = azurerm_subnet.business-tier-subnet.id
    private_ip_address_allocation = "Dynamic"

  }
}
