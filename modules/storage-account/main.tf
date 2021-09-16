resource "random_string" "storage_account_id" {
  keepers = {
    name = var.storage_account_name
  }

  length      = 3
  min_numeric = 1
  min_lower   = 1
  special     = false
  upper       = false

  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_storage_account" "foundation" {
  name                     = "${var.storage_account_name}${random_string.storage_account_id.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.region
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "terraform_state" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.foundation.name
  container_access_type = var.container_access_type
}

resource "azurerm_storage_queue" "terraform_events" {
  name                 = "terraform-events"
  storage_account_name = azurerm_storage_account.foundation.name
}
