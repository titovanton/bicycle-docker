#!/bin/bash

while [[ ! $PROJECT_NAME ]]; do
    read -p "Enter your new project name (required): " PROJECT_NAME
    echo
done
k=$(docker images postgres | grep postgres.*postgres || false)
if [[ ! $k ]]; then
    echo 'postgres:postgres image does not exists'
    exit 1
fi
k=$(docker images django | grep brand-new || false)
if [[ ! $k ]]; then
    echo 'django:brand-new does not exists'
    exit 1
fi

# DB
CID=$(docker run -d -e PROJECT_NAME=$PROJECT_NAME --name postgres-$PROJECT_NAME postgres:postgres /run.sh)
DB_PWD=$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32)
PG_HOST=$(docker inspect $CID | grep IPAddress | cut -d\" -f4)
file=$(mktemp)
curl https://raw.githubusercontent.com/titovanton/bicycle-docker/master/postgresql-node/createdb.sql -s > $file
psql -h $PG_HOST -U postgres -f $file -v passwd=\'$DB_PWD\' -v user=$PROJECT_NAME
rm $file

# Django
docker run -ti \
    --name django-create \
    --volumes-from nginx \
    --volumes-from samba \
    --link postgres-$PROJECT_NAME \
    --link elasticsearch \
    django:brand-new \
    /create_project.sh $PROJECT_NAME $DB_PWD
docker commit django-$PROJECT_NAME django:$PROJECT_NAME
docker rm django-create

# run
docker run -d \
    --name django-$PROJECT_NAME \
    --volumes-from nginx \
    --volumes-from samba \
    --link postgres-$PROJECT_NAME \
    --link elasticsearch \
    django:$PROJECT_NAME \
    /run.sh
