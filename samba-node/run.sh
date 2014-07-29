#!/bin/bash

/usr/sbin/smbd --foreground --log-stdout
chown -R $1:www-data /data