#!/bin/bash

SUBNET_ID="e9bporvqd9a61c41upt4"

terraform output -json internal_ip_address_app | jq -r '.[]' |
while IFS=$"\n" read -r ADDRESS; do
  echo $ADDRESS
  yc load-balancer target-group add-targets reddit-app-target-group --target address=$ADDRESS,subnet-id=$SUBNET_ID
done
