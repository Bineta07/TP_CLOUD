# storage.tf


resource "azurerm_storage_account" "main" {
  name                     = "stpt1storage"       # doit être unique globalement
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_storage_container" "container" {
  name                  = "backup-container"    # nom du container
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = "private"
}


data "azurerm_virtual_machine" "main_vm" {
  name                = azurerm_linux_virtual_machine.vm.name
  resource_group_name = azurerm_resource_group.rg.name
}


resource "azurerm_role_assignment" "vm_blob_access" {
  principal_id         = data.azurerm_virtual_machine.main_vm.identity[0].principal_id
  role_definition_name = "Storage Blob Data Contributor"
  scope                = azurerm_storage_account.main.id

  depends_on = [
    azurerm_linux_virtual_machine.vm
  ]
}
