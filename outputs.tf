output "public_ip" {
  description = "IP publique de la VM"
  value       = azurerm_public_ip.pubip.ip_address
}

output "dns_name" {
  description = "Nom DNS de la VM"
  value       = azurerm_public_ip.pubip.fqdn
}



output "storage_account_name" {
  value = azurerm_storage_account.main.name
}

output "storage_container_name" {
  value = azurerm_storage_container.container.name
}
output "keyvault_name" {
  value = azurerm_key_vault.meow_vault.name
}

output "secret_value" {
  value     = azurerm_key_vault_secret.meow_secret.value
  sensitive = true
}
