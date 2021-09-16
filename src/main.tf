data "azurerm_client_config" "current" {}

locals {
  resource_group_name  = "${var.platform_name}-foundation"
  key_vault_name       = "${var.company_name}-${var.platform_name}"
  storage_account_name = "${var.company_name}${var.platform_name}"

  administrators = [
    data.azurerm_client_config.current.object_id,
    "805a3d92-4178-4ad1-a0d6-70eae41a463a"
  ]
}

resource "azurerm_resource_group" "foundation" {
  name     = local.resource_group_name
  location = var.platform_region
}

module "vault" {
  source = "git@github.com:smsilva/azure-key-vault.git//src?ref=main"

  name           = local.key_vault_name
  resource_group = azurerm_resource_group.foundation
  administrators = local.administrators

  depends_on = [
    azurerm_resource_group.foundation
  ]
}

module "terraform_backend_storage" {
  source = "../modules/storage-account"

  region               = var.platform_region
  resource_group_name  = azurerm_resource_group.foundation.name
  storage_account_name = local.storage_account_name
}
