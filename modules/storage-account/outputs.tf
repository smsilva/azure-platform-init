output "resource_group_name" {
  value = var.resource_group_name
}

output "storage_account" {
  value = azurerm_storage_account.default
}

output "storage_container" {
  value = azurerm_storage_container.default
}
