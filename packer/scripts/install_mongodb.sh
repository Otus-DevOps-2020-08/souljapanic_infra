#!/bin/bash

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.2.list

echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

apt-get install -y -q

apt-get update

sleep 15s

apt-get install -y mongodb-org

systemctl enable mongod --now
