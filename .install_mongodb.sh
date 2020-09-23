#!/usr/bin/env bash

function installMongo {
	wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
	sudo bash -c 'echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.2.list'
	sudo apt update && sudo apt install -y mongodb-org
	sudo systemctl enable mongod --now
}

installMongo
