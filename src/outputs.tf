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
  value = module.terraform_backend_storage.storage_account.id
}

output "platform_storage_account_name" {
  value = module.terraform_backend_storage.storage_account.name
}

output "platform_storage_account_container_id" {
  value = module.terraform_backend_storage.storage_container_terraform_state.id
}

output "platform_storage_account_container_name" {
  value = module.terraform_backend_storage.storage_container_terraform_state.name
}

output "platform_storage_account_queue_id" {
  value = module.terraform_backend_storage.storage_queue_terraform_events.id
}

output "platform_storage_account_queue_name" {
  value = module.terraform_backend_storage.storage_queue_terraform_events.name
}

output "platform_storage_account_primary_access_key" {
  value     = module.terraform_backend_storage.storage_account.primary_access_key
  sensitive = true
}
