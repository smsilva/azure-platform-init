variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
  default     = ""
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
  default     = ""
}

variable "region" {
  type    = string
  default = "centralus"
}

variable "resource_group_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "platform_output_directory" {
  type        = string
  description = "Platform Initialization Output Directory"
}

variable "azure_devops_service_principal" {
  type        = string
  description = "AzureDevOps Service Principal"
  default     = "01ddf773-9cdc-48d7-b42d-3597ce153730"
}
