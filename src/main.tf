data "azurerm_client_config" "current" {}

locals {
  resource_group_name  = "${var.platform_name}-foundation"
  key_vault_name       = "${var.company_name}${var.platform_name}"
  storage_account_name = "${var.company_name}${var.platform_name}"
}

resource "azurerm_resource_group" "foundation" {
  name     = local.resource_group_name
  location = var.region
}

module "vault" {
  source = "../modules/azure-key-vault"

  name           = local.key_vault_name
  resource_group = azurerm_resource_group.foundation
  depends_on = [
    azurerm_resource_group.foundation
  ]
}

module "backend_storage" {
  source = "../modules/storage-account"

  region               = var.region
  resource_group_name  = local.resource_group_name
  storage_account_name = local.storage_account_name
  key_vault_id         = module.vault.id
  depends_on = [
    azurerm_resource_group.foundation,
    module.vault
  ]
}
