# bicycle-docker

## Create project

You have to specify <project_name> here:

    file=$(mktemp) && \
    curl -s https://raw.githubusercontent.com/titovanton/bicycle-docker/master/create_project.sh > $file && \
    sudo -E /bin/bash $file <project_name>  && \
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
        nginx:brand-new \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/nginx-node/Dockerfile

Run daemon container:

    sudo docker run -d \
        --name nginx \
        -p 80:80 \
        -p 443:443 \
        -p 8000:8000 \
        nginx:brand-new

## PostgreSQL node

It also contains Redis, Memcached and /static/ + /media/ folders

Build image:

    sudo docker build --rm -t \
        postgres:brand-new \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/postgresql-node/Dockerfile

Configure postgres user:

    sudo docker run -i -t \
        --name postgres-postgres \
        postgres:brand-new /bin/bash

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

    sudo docker commit postgres-postgres postgres:postgres && \
    sudo docker rm postgres-postgres

Now you have image ready to use in create_project script!


## Django node

Create a brand new django-node image if you did not yet:

    sudo docker build -t \
        django:brand-new \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/Dockerfile

Create user and configure login:

    sudo docker run -ti \
        --name django-useradd \
        django:brand-new \
        /create_user.sh $USER $(cat /home/$USERNAME/.ssh/id_rsa.pub) && \
    sudo docker commit django-useradd django:$USER && \
    sudo docker rm django-useradd && \
    sudo docker run -d \
        --name django-ssh \
        django:brand-new \
        /bin/bash && \
    IP=$(docker inspect django-ssh | grep IPAddress | cut -d\" -f4) && \
    ssh $USER@$IP

Now you have to create ssh key inside the container:

    EMAIL=mail@$USER.com && \
    
    mkdir -p /home/$USER/.ssh && \
    cd /home/$USER/.ssh && \
    ssh-keygen -t rsa -C "$EMAIL" && \
    eval `ssh-agent -s` && \
    ssh-add /home/$USER/.ssh/id_rsa && \
    exit

Commit container:



Create Django project, do not forget change `USERNAME` and `EMAIL` variables:

    export USERNAME=$USER; \
    export EMAIL=mail@$USER.com; \
    curl -s https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/create_project.sh | /bin/bash

## ElasticSearch node

Build image:

    sudo docker build --rm -t \
        elasticsearch:brand-new \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/elasticsearch-node/Dockerfile

Run daemon container:

    sudo docker run -d \
        --name elasticsearch \
        elasticsearch:brand-new

## Samba node

Prepare (set variables as you wish):

    USERNAME=$USER && SHARE=/data && \

    sudo mkdir -p $SHARE && \
    sudo chown -R root:www-data $SHARE && \
    sudo chmod 775 $SHARE && \
    sudo adduser $USERNAME www-data

Build image:

    sudo docker build --rm -t \
        samba:brand-new \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/Dockerfile

Configure user:

    sudo docker run -ti \
        --name samba-adduser \
        samba:brand-new \
        /create_user.sh $USERNAME && \
    sudo docker commit samba-adduser samba:$USERNAME && \
    sudo docker rm samba-adduser

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