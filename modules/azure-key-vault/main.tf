data "azurerm_client_config" "current" {}

locals {
  administrators = [
    { "name" = "terraform", "id" = data.azurerm_client_config.current.object_id },
    { "name" = "cloud_admins", "id" = "805a3d92-4178-4ad1-a0d6-70eae41a463a" }
  ]

  administrators_map = {
    for administrator in local.administrators : administrator.name => administrator
  }
}

resource "random_string" "key_vault_id" {
  keepers = {
    name     = var.name
    location = var.resource_group.location
  }

  length      = 3
  min_numeric = 1
  special     = false
  upper       = false
}

resource "azurerm_key_vault" "default" {
  name                       = "${var.name}${random_string.key_vault_id.result}"
  location                   = var.resource_group.location
  resource_group_name        = var.resource_group.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false # Should we change this to not allow a key vault be purged before retention period
}

resource "azurerm_key_vault_access_policy" "foundation_terraform_service_principal" {
  for_each = local.administrators_map

  key_vault_id = azurerm_key_vault.default.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.value.id

  certificate_permissions = [
    "Backup",
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "ManageContacts",
    "ManageIssuers",
    "Purge",
    "Recover",
    "Restore",
    "SetIssuers",
    "Update",
  ]

  key_permissions = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]
}
