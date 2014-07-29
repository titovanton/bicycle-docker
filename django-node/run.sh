#!/bin/bash

/usr/local/bin/uwsgi --init /data/uwsgi/$(hostname).ini \
--uid www-data --gid www-data --daemonize /data/uwsgi/log/$(hostname).log
/usr/sbin/sshd -D