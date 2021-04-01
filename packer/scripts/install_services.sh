#!/bin/sh -x

cp /home/ubuntu/puma.service /etc/systemd/system/puma.service
systemctl enable puma
