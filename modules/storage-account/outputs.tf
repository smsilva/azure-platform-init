output "resource_group_name" {
  value = var.resource_group_name
}

output "storage_account" {
  value = azurerm_storage_account.foundation
}

output "storage_container_terraform_state" {
  value = azurerm_storage_container.terraform_state
}

output "storage_queue_terraform_events" {
  value = azurerm_storage_queue.terraform_events
}
