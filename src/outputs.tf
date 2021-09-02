output "platform_backend_key" {
  value = module.terraform_backend_file.key
}

output "platform_backend_file_name" {
  value = module.terraform_backend_file.file_name
}

output "platform_storage_account_name" {
  value = module.backend_storage.storage_account.name
}

output "platform_storage_account_primary_access_key" {
  value     = module.backend_storage.storage_account.primary_access_key
  sensitive = true
}

output "platform_generated_config_file_directory" {
  value = local.output_directory
}

output "platform_storage_account_credentials" {
  value = "${local.output_directory}/credentials.conf"
}
