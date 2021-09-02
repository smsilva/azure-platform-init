# Azure Platform Initialization

## Create Initial Resources

- Resource Group
- Storage Account
- Storage Container

```bash
init-from-this-machine silvios mink
```

## Importing Already Created Resources if needed
```bash
terraform import -chdir=src module.backend.azurerm_resource_group.default    /subscriptions/${ARM_SUBSCRIPTION_ID?}/resourceGroups/${RESOURCE_GROUP_NAME?}
terraform import -chdir=src module.backend.azurerm_storage_account.default   /subscriptions/${ARM_SUBSCRIPTION_ID?}/resourceGroups/${RESOURCE_GROUP_NAME?}/providers/Microsoft.Storage/storageAccounts/${STORAGE_ACCOUNT_NAME?}
terraform import -chdir=src module.backend.azurerm_storage_container.default "https://${STORAGE_ACCOUNT_NAME?}.blob.core.windows.net/terraform"
```
