#!/bin/bash

NODE=''
AUTHOR=''
while [[ $NODE == '' ]]; do
    read -p "Enter container name: " NODE
done
while [[ $AUTHOR == '' ]]; do
    read -p "Enter author name: " AUTHOR
done

curl -s https://raw.githubusercontent.com/titovanton/bicycle-docker/master/auto_start.conf | \
sed -e "s/%NODE%/$NODE/g" \
    -e "s/%AUTHOR%/$AUTHOR/g" \
    > /etc/init/$NODE.conf
