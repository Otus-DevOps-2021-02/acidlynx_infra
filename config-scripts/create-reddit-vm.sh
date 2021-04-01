#!/bin/sh

APPNAME="reddit-app"
METADATA_FILENAME="metadata.yaml"
IMAGE_FAMILY="reddit-full"

# create new vm
yc compute instance create \
  --name ${APPNAME} \
  --hostname ${APPNAME} \
  --memory=4 \
  --create-boot-disk image-family=${IMAGE_FAMILY} \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=${METADATA_FILENAME}
