variable "company_name" {
  description = "Company Name that will be used to name foundation things like Storage Account and Key Vault."
  type        = string
}

variable "platform_name" {
  description = "Platform Name: this will be used to name foundation things like Storage Account and Key Vault."
  type        = string
}

variable "platform_region" {
  description = "Region to Create Platform Foundation Resources"
  type        = string
  default     = "centralus"
}
