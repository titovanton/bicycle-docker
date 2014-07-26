#!/bin/bash

if [[ $1 == name ]]; then
    hostname $2
    cp /node/uwsgi.ini /data/uwsgi/$(hostname).ini
else
    /usr/local/bin/uwsgi --init /data/uwsgi/$(hostname).ini \
    --uid www-data --gid www-data --daemonize /data/uwsgi/log/$(hostname).log
fi