#!/bin/bash

######################################################
#creting the user  with console and programatic access
######################################################


set -euo pipefail

#usage:
#./cli.sh <user_name> <passowrd> <policy_arn>
#Example:
#./cli.sh  amith-gowda "strongpassword123!" arn:aws:iam::aws:policy/AmazonReadOnlyAccess

USER_NAME=$1
PASSOWORD=$2
POLICY_ARN=$3

echo "creating the IAM user: $USER_NAME"
aws iam create-user --user-name "$USER_NAME" || echo "user may already exists."

echo "creating the console login profile"
aws iam create-login-profile \
	--user-name "$USER_NAME"
        --password "$PASSWORD"
	--password-reset-required  || echo "Login profile may already exists"

echo "createing programatic access key"
ACCESS_KEYS=$(aws iam create-access-key --user-name "$USER_NAME")

ACCESS_KEY_ID=$(echo "$ACCESS_KEYS" | jq -r .AccessKey.AccessKeyId)
SECRET_ACCESS_KEY=$(echo "$ACCESS_KEY" | jq -r .AccessKey.SecretAccessKey)

echo "Attaching policy: $POLICY_ARN"
aws iam attach-user-policy \
	--user-name "$USER_NAME" \
	--policy-arn "$POLICY_ARN"

echo "user created successfully"
echo"-------------------------"
echo "user name $USER_NAME"
echo"console login URL: https://$(aws sts get-caller-identity --querry 'Account' --output text).singin.aws.amazon"
echo"AccessKeyId: $ACCESS_KEY_ID "
echo"SecretAccessKey: $SECRET_ACCESS_KEY"
echo"-----------------------------------"
echo "save the Accesskey and secret key secret securely !This is onlly time you will get the secret."


