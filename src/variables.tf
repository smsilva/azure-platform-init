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
  type    = string
  default = "silvios-demo"
}

variable "storage_account_name" {
  type    = string
  default = "silviosdemo"
}
