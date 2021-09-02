output "platform_resource_group_name" {
  value = azurerm_resource_group.foundation.name
}

output "platform_storage_account_name" {
  value = module.backend_storage.storage_account.name
}

output "platform_storage_account_container_name" {
  value = module.backend_storage.storage_container.name
}

output "platform_storage_account_primary_access_key" {
  value     = module.backend_storage.storage_account.primary_access_key
  sensitive = true
}
