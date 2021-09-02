# Azure Platform Initialization

## Create Initial Resources

- Resource Group
- Storage Account
- Storage Container

```bash
azure-platform-init/scripts/init-from-this-machine silvios iguana
```

## Importing Already Created Resources if needed
```bash
terraform import -chdir=src module.backend.azurerm_resource_group.default    /subscriptions/${ARM_SUBSCRIPTION_ID?}/resourceGroups/${RESOURCE_GROUP_NAME?}
terraform import -chdir=src module.backend.azurerm_storage_account.default   /subscriptions/${ARM_SUBSCRIPTION_ID?}/resourceGroups/${RESOURCE_GROUP_NAME?}/providers/Microsoft.Storage/storageAccounts/${STORAGE_ACCOUNT_NAME?}
terraform import -chdir=src module.backend.azurerm_storage_container.default "https://${STORAGE_ACCOUNT_NAME?}.blob.core.windows.net/terraform"
```

## Purge Azure Key Vault Soft Deleted

```bash
while read -r AZURE_KEY_VAULT_NAME; do
  az keyvault purge -n ${AZURE_KEY_VAULT_NAME}
done <<< "$(az keyvault list-deleted --resource-type vault | jq -r .[].name)"
```
