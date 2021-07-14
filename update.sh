#!/bin/sh
PROFILE=default

echo "Setting up Okta ($PROFILE)..."
okta-awscli --okta-profile $PROFILE --profile $PROFILE
echo "Testing AWS CLI ($PROFILE)"
aws sts --profile $PROFILE get-caller-identity

