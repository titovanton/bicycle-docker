#!/bin/bash

while [[ ! $PROJECT_NAME ]]; do
    read -p "Enter Ubuntu/Git user name please (required): " PROJECT_NAME
    echo
done
# k=$(docker images postgres | grep postgres.*postgres || false)
# if [[ ! $k ]]; then
#     echo 'postgres:postgres image does not exists'
#     exit 1
# fi
k=$(docker images django | grep brand-new || false)
if [[ ! $k ]]; then
    echo 'django:brand-new does not exists'
    exit 1
fi

# DB
# CID=$(docker run -d -e PROJECT_NAME=$PROJECT_NAME --name postgres-$PROJECT_NAME postgres:postgres /run.sh)
# DB_PWD=$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32)
# PG_HOST=$(docker inspect $CID | grep IPAddress | cut -d\" -f4)
# file=$(mktemp)
# curl https://raw.githubusercontent.com/titovanton/bicycle-docker/master/postgresql-node/createdb.sql -s > $file
# psql -h $PG_HOST -U postgres -f $file -v passwd=\'$DB_PWD\' -v user=$PROJECT_NAME
# rm $file

# Django

sudo docker run -ti \
    --name django-create \
    django:brand-new \
    /create_project.sh $PROJECT_NAME $DB_PWD && \
sudo docker commit django-$PROJECT_NAME django:$USERNAME && \
sudo docker rm django-create

