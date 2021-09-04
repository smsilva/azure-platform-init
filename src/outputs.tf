output "platform_resource_group_name" {
  value = azurerm_resource_group.foundation.name
}

output "platform_key_vault_id" {
  value = module.vault.instance.id
}

output "platform_key_vault_name" {
  value = module.vault.instance.name
}

output "platform_storage_account_id" {
  value = module.backend_storage.storage_account.id
}

output "platform_storage_account_name" {
  value = module.backend_storage.storage_account.name
}

output "platform_storage_account_container_id" {
  value = module.backend_storage.storage_container.id
}

output "platform_storage_account_container_name" {
  value = module.backend_storage.storage_container.name
}

output "platform_storage_account_primary_access_key" {
  value     = module.backend_storage.storage_account.primary_access_key
  sensitive = true
}
