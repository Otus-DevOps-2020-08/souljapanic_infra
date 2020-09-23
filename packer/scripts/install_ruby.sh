#!/bin/bash

echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

apt-get install -y -q

apt-get  update

sleep 15s

apt-get install -y ruby-full ruby-bundler build-essential git
