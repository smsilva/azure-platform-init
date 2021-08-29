output "platform_storage_account_name" {
  value     = module.backend.storage_account.name
}

output "platform_storage_account_primary_access_key" {
  value     = module.backend.storage_account.primary_access_key
  sensitive = true
}
