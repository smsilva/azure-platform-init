module "backend" {
  source = "../modules/storage-account"

  region               = var.region
  resource_group_name  = var.resource_group_name
  storage_account_name = var.storage_account_name
}

data "template_file" "backend" {
  template = file("${path.module}/../templates/backend.conf")

  vars = {
    backend_resource_group_name  = module.backend.resource_group.name
    backend_storage_account_name = module.backend.storage_account.name
    backend_container_name       = module.backend.storage_container.name
    backend_key                  = "platform.tfstate.json"
  }
}

resource "local_file" "backend" {
  content         = data.template_file.backend.rendered
  filename        = "${path.module}/../output/backend.conf"
  file_permission = "0644"
}
