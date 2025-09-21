resource "azurerm_network_security_group" "vm_nsg" {
    name         = "vm-nsg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "ssh_rule" {
  name                        = "SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "2222"
  source_address_prefix       = "37.165.48.33" 
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.vm_nsg.name
}


resource "azurerm_network_interface_security_group_association" "nic_assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}