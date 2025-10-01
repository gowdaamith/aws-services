#!/bin/bash

#---------------------------------
#1.take input from the user
#---------------------------------

read -p "Enter the IAM group name(default: developergroup)"GROUP_NAME
GROUP_NAME=${GROUP_NAME: -DEVELOPERGROUP}

read -p "Enter the name of the user(default: devuser)"USER_NAME
USER_NAME=${USER_NAME: -DEV}

read -p "enter the policy arn to attach (default: AmazonS3ReadOnlyAccess):"POLICY_ARN
POLICY_ARN=${POLICY_ARN: -arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess}

read -p "enter the password length:"PASSOWORD_LENGTH
PASSWORD_LENGTH=${PASSWORD_LENGTH: -7}

#########################################
# Create the IAM group
# ######################################

aws iam create-group --group-name "$GROUP_NAME"
echo "IAM group '$GROUP_NAME' created"

##########################################
#Attach managed policies
#########################################

aws iam attach-group-policy --group-name "$GROUP_NAME" --policy-arn "$POLICY_ARN"
echo "policy $POLICY_ARN attaCHED TO THE GROUP $GROUP_NAME"

#########################################################
# Generate a random passoword
# #######################################################

USER_PASSWORD=$9openssl rand -base64 48 |tr -dc 'A-Za-z0-9' | head -c $PASSWORD_LENGTH)
echo "Random password generated for the user $USER_NAME."

#===========================================================
#CFREATE IAM USER WITH CONSOLE LOGIN
#############################################################

aws iam  create-user --user-name "$USER_NAME"
aws iam create-login-profile \
	--user-name "$USER_NAME" \
	--password "$USER_PASSWORD" \
	--password-length "$PASSWORD_LENGTH" \
	--password-reset-required
echo "IAM user with '$USER_NAME'  created with the consoel access"

###########################################################
#Add user to the group
###########################################################

aws iam add-user-to-group --user-name "$USER_NAME"  --group-name " $GROUP_NAME"
echo "User '$USER_NAME' ADD TO THE GROUP '$GROUP_NAME'"

#######################################################
#Create the access key
######################################################

ACCESS_KEY=$(aws iam create-access-key --user-name"$USER_NAME" )
ACCESS_KEY_ID=$(echo $ACCESS_KEYS | jq -r '.AccessKey.AccessKeyID')
SECRET_ACCESS_KEY=$(echo $ACCESS_KEY | jq -r '.AccessKey.SecreatAccessKey')


echo "Access Key created for user '$USER_NAME'."

# ----------------------------
# 8. Output credentials
# ----------------------------
echo "---------------------------------------"
echo "Console login URL: https://console.aws.amazon.com/"
echo "Username: $USER_NAME"
echo "Password: $USER_PASSWORD"
echo "Access Key ID: $ACCESS_KEY_ID"
echo "Secret Access Key: $SECRET_ACCESS_KEY"
echo "---------------------------------------"

