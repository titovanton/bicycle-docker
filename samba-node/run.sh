#!/bin/bash

/usr/sbin/smbd --foreground --log-stdout
chown -R root:www-data /data