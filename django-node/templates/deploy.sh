#!/bin/bash
# expample: sudo ./deploy.sh username

if [ ! $1 ]; then
    USR=titovanton
else
    USR=$1
fi

chown -R root:www-data /data/django/%PROJECT_NAME%
chown -R root:www-data /data/static/%PROJECT_NAME%
chown -R root:www-data /data/media/%PROJECT_NAME%
chown -R root:www-data /data/internal/%PROJECT_NAME%
chmod -R 771 /data/django/%PROJECT_NAME%
chmod -R 775 /data/static/%PROJECT_NAME%
chmod -R 775 /data/media/%PROJECT_NAME%
chmod -R 775 /data/internal/%PROJECT_NAME%
touch reload_uwsgi
