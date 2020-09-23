#!/bin/bash

echo "deb https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.2.list

echo "deb https://repo.pritunl.com/stable/apt bionic main" > /etc/apt/sources.list.d/pritunl.list

apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv E162F504A20CDF15827F718D4B7C549A058F8B6B

apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A

apt-get --assume-yes update

apt-get --assume-yes install pritunl mongodb-server

systemctl start pritunl mongodb

systemctl enable pritunl mongodb
