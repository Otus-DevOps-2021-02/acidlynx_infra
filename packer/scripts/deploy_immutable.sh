#!/bin/sh -x

echo "run deploy"

cd ~/

git clone -b monolith https://github.com/express42/reddit.git

cd reddit

bundle install
bundle binstubs puma --path ./sbin
