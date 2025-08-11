#!/bin/bash
set -e

STACK_NAME="demo-ec2-stack"
TEMPLATE_FILE="templates/main.yaml"
REGION="ap-south-1"

echo "=== Validating template ==="
aws cloudformation validate-template \
  --template-body file://$TEMPLATE_FILE

echo -e "\n=== Creating change set (dry-run) ==="
aws cloudformation create-change-set \
  --stack-name $STACK_NAME \
  --change-set-name dryrun-$(date +%s) \
  --template-body file://$TEMPLATE_FILE \
  --parameters \
      ParameterKey=KeyPairName,ParameterValue="my-keypair" \
      ParameterKey=InstanceType,ParameterValue="t2.micro" \
  --change-set-type CREATE \
  --region $REGION

echo -e "\nDry-run complete. No resources created."
