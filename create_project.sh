#!/bin/bash

if [[ $# < 1 ]]; then
    echo 'PROJECT_NAME is missed'
    exit 1
else
    PROJECT_NAME=$1
fi
k=$(docker images postgres | grep brand-new || false)
if [[ ! $k ]]; then
    echo 'postgres:brand-new does not exists'
    exit 1
fi
k=$(docker images django | grep brand-new || false)
if [[ ! $k ]]; then
    echo 'django:brand-new does not exists'
    exit 1
fi

CID=$(sudo docker run -it -e PROJECT_NAME=$PROJECT_NAME \
    --name postgres-$PROJECT_NAME postgres:brand-new sudo -i -u postgres)
CID=$(sudo docker run -de PROJECT_NAME=$PROJECT_NAME \
    --name postgres-$PROJECT_NAME postgres:brand-new) && \
DB_PWD=$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32) && \
PG_HOST=$(sudo docker inspect $CID | grep IPAddress | cut -d\" -f4) && \
file=$(mktemp) && \
curl https://raw.githubusercontent.com/titovanton/bicycle-docker/master/postgresql-node/createdb.sql -s > $file && \
psql -h $PG_HOST -U postgres -f $file -v passwd=\'$DB_PWD\' -v user=$PROJECT_NAME && \
rm $file
