#!/bin/sh -x

echo "run install ruby"

killall apt apt-get

apt-get update

sleep 20

apt-get install -y ruby-full ruby-bundler build-essential git
