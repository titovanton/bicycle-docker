#!/bin/bash

if [[ $# -ne 1 ]]; then
    USERNAME=djangouser
else
    USERNAME=$1
fi
useradd --no-log-init --no-create-home --no-user-group $USERNAME
smbpasswd -a $USERNAME
smbpasswd -e $USERNAME
adduser $USERNAME www-data
