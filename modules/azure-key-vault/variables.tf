variable "name" {
  type        = string
  description = "Azure Key Vault Name"
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Azure Key Vault Resource Group"
}
