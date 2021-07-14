#!/bin/sh
setup_file=~/.okta-aws
aws_config=~/.aws/config
# pip3 install okta-awscli
user=$USER

if [ -d ~/.aws ]
then
    mv ~/.aws ~/.aws-backup
fi

rm -rf $setup_file
touch $setup_file
cat <<EOT >> $setup_file
[default]
username = $user@groundx.xyz
factor = OKTA
app-link = https://groundx.okta.com/home/amazon_aws/0oa3b7q2dEHRFlkab5d6/272
base-url = groundx.okta.com
duration = 604800

[service-dev]
username = $user@groundx.xyz
factor = OKTA
app-link = https://groundx.okta.com/home/amazon_aws/0oa3b7q2dEHRFlkab5d6/272
base-url = groundx.okta.com
duration = 604800

[service-prod]
username = $user@groundx.xyz
factor = OKTA
app-link = https://groundx.okta.com/home/amazon_aws/0oa10gs49r83z98Hy5d7/272
base-url = groundx.okta.com
duration = 604800
EOT

mkdir -p ~/.aws
touch $aws_config
cat <<EOT >> $aws_config
[default]
region = ap-northeast-2
output=json

[service-dev]
region = ap-northeast-2
output=json

[service-prod]
region = ap-northeast-2
output=json
EOT

echo "Setting up Okta (default)..."
okta-awscli --okta-profile default --profile default
echo "Testing AWS CLI (default)"
aws sts get-caller-identity

echo ""
echo "Setting up Okta (service-dev)..."
okta-awscli --okta-profile service-dev --profile service-dev
echo "Testing AWS CLI (service-dev)"
aws sts --profile service-dev get-caller-identity

echo ""
echo "Setting up Okta (service-prod)..."
okta-awscli --okta-profile service-prod --profile service-prod 
echo "Testing AWS CLI (service-dev)"
aws sts --profile service-prod get-caller-identity

echo ""
echo "Setting up Kubernetes Clusters for Development Team"
echo "Updating kubernetes config for DEV"
aws --profile default eks update-kubeconfig --name service-dev-common --region ap-northeast-2

echo "Updating kubernetes config for QA"
aws --profile default eks update-kubeconfig --name service-qa-common --region ap-northeast-2

echo "Updating kubernetes config for PERF"
aws --profile default eks update-kubeconfig --name service-qa-perf --region ap-northeast-2

echo "Updating kubernetes config for PROD"
aws --profile service-prod eks update-kubeconfig --name service-prod-common --region ap-northeast-2
