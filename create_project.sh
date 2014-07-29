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
k=$(docker images django | grep brandnew || false)
if [[ ! $k ]]; then
    echo 'django:brandnew does not exists'
    exit 1
fi

# DB
CID=$(docker run -d --name postgres_$PROJECT_NAME postgres:postgres /run.sh)
DB_PWD=$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32)
PG_HOST=$(docker inspect $CID | grep IPAddress | cut -d\" -f4)
file=$(mktemp)
curl https://raw.githubusercontent.com/titovanton/bicycle-docker/master/postgresql-node/createdb.sql -s > $file
psql -h $PG_HOST -U postgres -f $file -v passwd=\'$DB_PWD\' -v user=$PROJECT_NAME
rm $file

# Django
docker run -ti \
    --name django_create \
    --volumes-from nginx \
    --volumes-from samba \
    --link postgres_$PROJECT_NAME:DB \
    --link elasticsearch:ES \
    django:brandnew \
    /create_project.sh $PROJECT_NAME $DB_PWD
docker commit django_$PROJECT_NAME django:$PROJECT_NAME
docker rm django_create

# run
docker run -d \
    --name django_$PROJECT_NAME \
    --volumes-from nginx \
    --volumes-from samba \
    --link postgres_$PROJECT_NAME:DB \
    --link elasticsearch:ES \
    django:$PROJECT_NAME \
    /run.sh
