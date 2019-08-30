#!/bin/bash

echo 'Region:'$region 
echo 'vpc_cidr:'$VPC_CIDR
echo 'env:'$ENV
echo 'PublicSubnet:'$PublicSubnetAZCIDR

./terraform init

./terraform apply -auto-approve -var 'region='$region  -var 'aws_access_key='$AWS_ACCESS_KEY -var 'aws_secret_key='$AWS_SECRET_KEY -var 'vpc_cidr='$VPC_CIDR -var 'env='ENV -var 'subnet_cidr='$PublicSubnetAZCIDR    



