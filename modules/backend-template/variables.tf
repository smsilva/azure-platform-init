variable "backend" {
  default = {
    resource_group = {
      name = ""
    }

    storage_account = {
      name = ""
    }
  }
}

variable "key" {
  type = string
  description = "Backend key"
}

variable "template_file_name" {
  type = string
  description = "Template File Name"
}

variable "output_file_name" {
  type = string
  description = "Template File Name"
}
