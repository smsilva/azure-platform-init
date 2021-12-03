#!/bin/bash

AZURE_RESOURCE_GROUP_NAME="wasp-foundation"
AZURE_STORAGE_ACCOUNT_NAME="waspfoundationb8873609"
AZURE_LOCATION="centralus"

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
