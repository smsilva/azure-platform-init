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
