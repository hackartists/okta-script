#!/bin/sh
PROFILE=default

echo "Setting up Okta ($PROFILE)..."
okta-awscli --okta-profile default --profile default
echo "Testing AWS CLI ($PROFILE)"
aws sts get-caller-identity

