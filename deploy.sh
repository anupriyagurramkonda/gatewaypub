#!/bin/bash

echo "Region:" $1
echo "Bucket Name:" $2

./terraform init

./terraform apply -auto-approve -var 'region='$1 



