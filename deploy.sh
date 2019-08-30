#!/bin/bash

echo 'Region:'$region 
echo 'vpc_cidr:'$vpc_cidr
echo 'name:'$Name
echo 'subnet:'$subnet_cidr
echo 'subnet_az:'$subnet_az

./terraform init

./terraform apply -auto-approve -var 'region='$region  -var 'aws_access_key='$AWS_ACCESS_KEY -var 'aws_secret_key='$AWS_SECRET_KEY -var 'vpc_cidr='$vpc_cidr -var 'name='$Name -var 'subnet_cidr='$subnet_cidr -var 'subnet_az='$subnet_az    



