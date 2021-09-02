# Azure Platform Initialization

## Create Initial Resources

- Resource Group
- Storage Account
- Storage Container

```bash
azure-platform-init/scripts/init-from-this-machine silvios teju
```

## Importing Already Created Resources if needed
```bash
terraform import -chdir=src module.backend.azurerm_resource_group.default    /subscriptions/${ARM_SUBSCRIPTION_ID?}/resourceGroups/${RESOURCE_GROUP_NAME?}
terraform import -chdir=src module.backend.azurerm_storage_account.default   /subscriptions/${ARM_SUBSCRIPTION_ID?}/resourceGroups/${RESOURCE_GROUP_NAME?}/providers/Microsoft.Storage/storageAccounts/${STORAGE_ACCOUNT_NAME?}
terraform import -chdir=src module.backend.azurerm_storage_container.default "https://${STORAGE_ACCOUNT_NAME?}.blob.core.windows.net/terraform"
```

## Purge Azure Key Vault Soft Deleted

`WARNING: Running the script below will PURGE and PERMANENT DELETE any previously deleted Azure Key Vault on the actual Subscription. Be careful.`

```bash
while read -r AZURE_KEY_VAULT_NAME; do
  echo "${AZURE_KEY_VAULT_NAME}"
  az keyvault purge -n ${AZURE_KEY_VAULT_NAME}
  echo ""
done <<< "$(az keyvault list-deleted --resource-type vault --output tsv --query '[].name')"
```

Note: if you get the error `"(MethodNotAllowed) Operation 'DeletedVaultPurge' is not allowed."` as explained [here](https://stackoverflow.com/a/64094916/6406538):

> _"The reason is that you have enabled the **Purge protection** when you create the keyvault._
> 
> _**Once the Purge protection is enabled, it's not allowed to delete it**. Please refer to the doc for more details. I just pasted part of the doc as below:_
> 
> _**When purge protection is turned on**, a **vault** or an **object** in deleted state **cannot be purged until the retention period has passed**._
> 
> _And please also note that, **if the Purge protection is enabled**, **you cannot disable it**._
> 
> _So during creating the key vault, please make sure the Purge protection is disabled, then try the command again."_
