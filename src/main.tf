data "azurerm_client_config" "current" {}

module "backend_storage" {
  source = "../modules/storage-account"

  region               = var.region
  resource_group_name  = var.resource_group_name
  storage_account_name = var.storage_account_name
}

module "terraform_backend_file" {
  source = "../modules/backend-template"

  backend            = module.backend_storage
  key                = "foundation/state.json"
  template_file_name = "${path.module}/../templates/backend.conf"
  output_file_name   = "${var.platform_output_directory}/backend.conf"
}

data "azurerm_resource_group" "foundation" {
  name = var.resource_group_name

  depends_on = [
    module.backend_storage
  ]
}

resource "azurerm_key_vault" "foundation" {
  name                       = var.key_vault_name
  location                   = data.azurerm_resource_group.foundation.location
  resource_group_name        = data.azurerm_resource_group.foundation.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
}

//resource "azurerm_key_vault_access_policy" "foundation_terraform" {
//  key_vault_id = azurerm_key_vault.foundation.id
//  tenant_id    = data.azurerm_client_config.current.tenant_id
//  object_id    = data.azurerm_client_config.current.object_id
//
//  certificate_permissions = [
//    "Backup",
//    "Create",
//    "Delete",
//    "DeleteIssuers",
//    "Get",
//    "GetIssuers",
//    "Import",
//    "List",
//    "ListIssuers",
//    "ManageContacts",
//    "ManageIssuers",
//    "Purge",
//    "Recover",
//    "Restore",
//    "SetIssuers",
//    "Update",
//  ]
//
//  key_permissions = [
//    "Backup",
//    "Create",
//    "Decrypt",
//    "Delete",
//    "Encrypt",
//    "Get",
//    "Import",
//    "List",
//    "Purge",
//    "Recover",
//    "Restore",
//    "Sign",
//    "UnwrapKey",
//    "Update",
//    "Verify",
//    "WrapKey",
//  ]
//
//  secret_permissions = [
//    "Backup",
//    "Delete",
//    "Get",
//    "List",
//    "Purge",
//    "Recover",
//    "Restore",
//    "Set",
//  ]
//}

//resource "azurerm_key_vault_access_policy" "foundation_azure_devops" {
//  key_vault_id = azurerm_key_vault.foundation.id
//  tenant_id    = data.azurerm_client_config.current.tenant_id
//  object_id    = var.azure_devops_service_principal
//
//  key_permissions = [
//    "List",
//    "Get",
//  ]
//
//  secret_permissions = [
//    "List",
//    "Set",
//    "Get"
//  ]
//}

//resource "azurerm_key_vault_secret" "foundation_storage_account" {
//  key_vault_id = azurerm_key_vault.foundation.id
//  name         = "${var.key_vault_name}-sa-primary-acces-key"
//  value        = module.backend_storage.storage_account.primary_access_key
//}
