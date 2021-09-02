terraform {
  required_version = ">= 0.15.0, < 2.0.0"

  backend "local" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.72.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      # Should the azurerm_key_vault, azurerm_key_vault_certificate, azurerm_key_vault_key and azurerm_key_vault_secret resources be permanently deleted (e.g. purged) when destroyed? Defaults to true
      purge_soft_delete_on_destroy = false

      # Should the azurerm_key_vault, azurerm_key_vault_certificate, azurerm_key_vault_key and azurerm_key_vault_secret resources recover a Soft-Deleted Key Vault/Item? Defaults to true
      recover_soft_deleted_key_vaults = true
    }
  }
}
