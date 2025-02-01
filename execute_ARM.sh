#!/bin/bash

# Variables
RESOURCE_GROUP="MyResourceGroup"
LOCATION="westus"
TEMPLATE_FILE="azure_arm_template.json"
DEPLOYMENT_NAME="VNET-Deployment"

# Login to Azure (if not already logged in)
az login

# Create Resource Group
az group create --name $RESOURCE_GROUP --location $LOCATION

# Deploy ARM Template
DEPLOYMENT_OUTPUT=$(az deployment group create \
  --name $DEPLOYMENT_NAME \
  --resource-group $RESOURCE_GROUP \
  --template-file $TEMPLATE_FILE \
  --parameters location1=westus location2=southindia)

# Check if deployment was successful
if echo "$DEPLOYMENT_OUTPUT" | grep -q '"provisioningState": "Succeeded"'; then
  echo "Deployment complete!"
else
  echo "Deployment failed!"
  echo "$DEPLOYMENT_OUTPUT"
  exit 1
fi
