# bicycle-docker

## Create a project

    file=$(mktemp) && \
    curl -s https://raw.githubusercontent.com/titovanton/bicycle-docker/master/create_project.sh > $file && \
    sudo -E /bin/bash $file  && \
    rm $file

## Iptables

It is important to install iptables rules before installing docker, because of docker add his own rules:

    file=$(mktemp) && \
    curl -s https://raw.githubusercontent.com/titovanton/bicycle-docker/master/iptables/add_rules.sh > $file && \
    sudo /bin/bash $file && \
    rm $file


## Install Docker and prepare

Ubuntu 14.04 LTS:

    EMAIL=mail@$USER.com && \

    curl -s https://get.docker.io/ubuntu/ | sudo sh && \
    sudo sh -c "echo 'DOCKER_OPTS=\"-r=false\"' > /etc/default/docker" && \
    sudo apt-get upgrade -y && \
    sudo apt-get install -y postgresql-client && \
    mkdir -p /home/$USER/.ssh && \
    cd /home/$USER/.ssh && \
    ssh-keygen -t rsa -C "$EMAIL" && \
    eval `ssh-agent -s` && \
    ssh-add /home/$USER/.ssh/id_rsa

## Basic images:

    sudo docker build --rm -t \
        ubuntu:base \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/ubuntu/Dockerfile && \
    sudo docker build --rm -t \
        django:base \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django/Dockerfile && \
    sudo docker build --rm -t \
        postgres:base \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/postgresql/Dockerfile

## Nginx node

Build image:

    sudo docker build --rm -t \
        nginx:brandnew \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/nginx-node/Dockerfile

Run daemon container:

    sudo docker run -d \
        --name nginx \
        -p 80:80 \
        -p 443:443 \
        -p 8000:8000 \
        nginx:brandnew

## PostgreSQL node

It also contains Redis, Memcached and /static/ + /media/ folders

Build image:

    sudo docker build --rm -t \
        postgres:brandnew \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/postgresql-node/Dockerfile

Configure postgres user:

    sudo docker run -i -t \
        --name postgres_postgres \
        postgres:brandnew /bin/bash

start postgresql and login by postgres user:

    service postgresql start && \
    sudo -i -u postgres

now you have to execute:
    
    psql

then:
    
    \password

enter password, prompt, then:

    \q

and logout postgres:

    exit

stop container:

    exit

commit container:

    sudo docker commit postgres_postgres postgres:postgres && \
    sudo docker rm postgres_postgres

Now you have image ready to use in create_project script!


## Django node

Create a brand new django-node image if you did not yet:

    sudo docker build --rm -t \
        django:brandnew \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/Dockerfile

## ElasticSearch node

Build image:

    sudo docker build --rm -t \
        elasticsearch:brandnew \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/elasticsearch-node/Dockerfile

Run daemon container:

    sudo docker run -d \
        --name elasticsearch \
        elasticsearch:brandnew

## Samba node

Prepare (set variables as you wish):

    USERNAME=$USER && SHARE=/data && \

    sudo mkdir -p $SHARE && \
    sudo chown -R root:www-data $SHARE && \
    sudo chmod 775 $SHARE && \
    sudo adduser $USERNAME www-data

Build image:

    sudo docker build --rm -t \
        samba:brandnew \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/Dockerfile

Configure user:

    sudo docker run -ti \
        --name samba_adduser \
        samba:brandnew \
        /create_user.sh $USERNAME && \
    sudo docker commit samba_adduser samba:$USERNAME && \
    sudo docker rm samba_adduser

Run daemon container and mount a share to local file system:

    USERNAME=$USER && \

    sudo docker run -d \
        --name samba \
        -v /data:/data \
        -p 137:137/udp \
        -p 138:138/udp \
        -p 135:135/tcp \
        -p 139:139/tcp \
        -p 445:445/tcp \
        samba:$USERNAME /run.sh $USERNAME

## Automatically Start Containers

    file=$(mktemp) && \
    curl -s https://raw.githubusercontent.com/titovanton/bicycle-docker/master/auto_start.sh > $file && \
    sudo /bin/bash $file && \
    rm $file