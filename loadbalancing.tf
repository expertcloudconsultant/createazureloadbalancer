#Create Load Balancer
resource "azurerm_lb" "business-tier-lb" {
  name                = "business-tier-lb"
  location            = azurerm_resource_group.corporate-production-rg.location
  resource_group_name = azurerm_resource_group.corporate-production-rg.name

  frontend_ip_configuration {
    name                          = "businesslbfrontendip"
    subnet_id                     = azurerm_subnet.business-tier-subnet.id
    private_ip_address            = var.env == "Static" ? var.private_ip : null
    private_ip_address_allocation = var.env == "Static" ? "Static" : "Dynamic"
  }
}


#Create Loadbalancing Rules
resource "azurerm_lb_rule" "production-inbound-rules" {
  loadbalancer_id                = azurerm_lb.business-tier-lb.id
  resource_group_name            = azurerm_resource_group.corporate-production-rg.name
  name                           = "ssh-inbound-rule"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  frontend_ip_configuration_name = "businesslbfrontendip"
  probe_id                       = azurerm_lb_probe.ssh-inbound-probe.id
  backend_address_pool_ids        = ["${azurerm_lb_backend_address_pool.business-backend-pool.id}"]
 

}


#Create Probe
resource "azurerm_lb_probe" "ssh-inbound-probe" {
  resource_group_name = azurerm_resource_group.corporate-production-rg.name
  loadbalancer_id     = azurerm_lb.business-tier-lb.id
  name                = "ssh-inbound-probe"
  port                = 22
}


#Create Backend Address Pool
resource "azurerm_lb_backend_address_pool" "business-backend-pool" {
  loadbalancer_id = azurerm_lb.business-tier-lb.id
  name            = "business-backend-pool"
}


#Automated Backend Pool Addition > Gem Configuration to add the network interfaces of the VMs to the backend pool.
resource "azurerm_network_interface_backend_address_pool_association" "business-tier-pool" {
  count                   = 2
  network_interface_id    = azurerm_network_interface.corpnic.*.id[count.index]
  ip_configuration_name   = azurerm_network_interface.corpnic.*.ip_configuration.0.name[count.index]
  backend_address_pool_id = azurerm_lb_backend_address_pool.business-backend-pool.id

}

