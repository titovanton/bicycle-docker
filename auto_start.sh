#!/bin/bash

read -p "Enter container name: " NODE
read -p "Enter author name: " AUTHOR
# NODE=''
# AUTHOR=''
# while [[ $NODE == '' ]]; do
# done
# while [[ $AUTHOR == '' ]]; do
# done

curl -s https://raw.githubusercontent.com/titovanton/bicycle-docker/master/auto_start.conf | \
sed -e 's/%NODE%/$NODE/g' \
    -e 's/%AUTHOR%/$AUTHOR/g' \
    > /etc/init/$NODE.conf
