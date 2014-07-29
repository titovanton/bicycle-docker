#!/bin/bash

USERNAME=$1
RSA=$2
useradd $USERNAME -m -G sudo www-data
mkdir -p /home/$USERNAME/.ssh
id_rsa.pub /home/$USERNAME/.ssh
echo $RSA >> /home/$USERNAME/.ssh/authorized_keys
chmod 600 /home/$USERNAME/.ssh/authorized_keys
