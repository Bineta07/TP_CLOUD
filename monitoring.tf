# Groupe d’action (envoie l’alerte par mail)
resource "azurerm_monitor_action_group" "main" {
  name                = "ag-${azurerm_resource_group.rg.name}-alerts"
  resource_group_name = azurerm_resource_group.rg.name
  short_name          = "vm-alerts"

  email_receiver {
    name          = "admin"
    email_address = var.alert_email_address
  }
}

# Alerte CPU > 70%
resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "cpu-alert-${azurerm_linux_virtual_machine.vm.name}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [azurerm_linux_virtual_machine.vm.id]
  description         = "Alert when CPU usage exceeds 70%"
  severity            = 2

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 70
  }

  window_size   = "PT5M"
  frequency     = "PT1M"
  auto_mitigate = true

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}
