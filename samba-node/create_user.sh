#!/bin/bash

useradd --no-log-init --no-create-home --no-user-group $1
# smbpasswd -a $1
# smbpasswd -e $1