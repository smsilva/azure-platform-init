data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "foundation" {
  name     = var.resource_group_name
  location = var.region
}

module "vault" {
  source = "../modules/azure-key-vault"

  name           = var.key_vault_name
  resource_group = azurerm_resource_group.foundation

  depends_on = [
    azurerm_resource_group.foundation
  ]
}

module "backend_storage" {
  source = "../modules/storage-account"

  region               = var.region
  resource_group_name  = var.resource_group_name
  storage_account_name = var.storage_account_name
  key_vault_id         = module.vault.id
}

module "terraform_backend_file" {
  source = "../modules/backend-template"

  backend            = module.backend_storage
  key                = "foundation/state.json"
  template_file_name = "${path.module}/../templates/backend.conf"
  output_file_name   = "${var.platform_output_directory}/backend.conf"
}
