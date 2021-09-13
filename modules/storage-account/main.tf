resource "random_string" "storage_account_id" {
  keepers = {
    name = var.storage_account_name
  }

  length      = 3
  min_numeric = 1
  special     = false
  upper       = false

  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_storage_account" "default" {
  name                     = "${var.storage_account_name}${random_string.storage_account_id.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "default" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.default.name
  container_access_type = "private"

  depends_on = [
    azurerm_storage_account.default
  ]
}

resource "azurerm_key_vault_secret" "foundation_storage_account_primary_access_key" {
  key_vault_id = var.key_vault_id
  name         = "storage-account-${azurerm_storage_account.default.name}-primary-acces-key"
  value        = azurerm_storage_account.default.primary_access_key

  depends_on = [
    azurerm_storage_account.default
  ]
}

resource "azurerm_storage_queue" "terraform_events" {
  name                 = "terraform-events"
  storage_account_name = azurerm_storage_account.default.name
}
