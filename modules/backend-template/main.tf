data "template_file" "backend_template" {
  template = file(var.template_file_name)

  vars = {
    backend_resource_group_name  = var.backend.resource_group.name
    backend_storage_account_name = var.backend.storage_account.name
    backend_container_name       = var.backend.storage_container.name
    backend_key                  = var.key
  }
}

resource "local_file" "backend_file" {
  content         = data.template_file.backend_template.rendered
  filename        = var.output_file_name
  file_permission = "0644"
}
