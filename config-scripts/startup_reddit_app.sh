#!/bin/sh

APPNAME="reddit-app1"
METADATA_FILENAME="metadata.yaml"

# create new vm
yc compute instance create \
  --name ${APPNAME} \
  --hostname ${APPNAME} \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=${METADATA_FILENAME}
