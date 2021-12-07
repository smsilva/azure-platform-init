#!/bin/bash

SUBSCRIPTION_ID=$(az account show \
  --output tsv \
  --query id)

AZURE_RESOURCE_GROUP_NAME="wasp-foundation"
AZURE_STORAGE_ACCOUNT_NAME="waspfoundation$(awk -F '-' '{ print $1 }' <<< "${SUBSCRIPTION_ID}")"
AZURE_LOCATION="centralus"

echo "AZURE_RESOURCE_GROUP_NAME..: ${AZURE_RESOURCE_GROUP_NAME}"
echo "AZURE_STORAGE_ACCOUNT_NAME.: ${AZURE_STORAGE_ACCOUNT_NAME}"
echo "AZURE_LOCATION.............: ${AZURE_LOCATION}"

az group create \
  --resource-group "${AZURE_RESOURCE_GROUP_NAME}" \
  --location "${AZURE_LOCATION}"

az storage account create \
  --name "${AZURE_STORAGE_ACCOUNT_NAME}" \
  --resource-group "${AZURE_RESOURCE_GROUP_NAME}"

az storage container create \
  --name terraform \
  --account-name "${AZURE_STORAGE_ACCOUNT_NAME}" \
  --resource-group "${AZURE_RESOURCE_GROUP_NAME}"
