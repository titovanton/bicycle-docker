# bicycle-docker

## Install Docker

Ubuntu 14.04 LTS:

    curl -s https://get.docker.io/ubuntu/ | sudo sh
    sudo sh -c "echo 'DOCKER_OPTS=\"-r=false\"' > /etc/default/docker"

## Iptables

    file=$(mktemp) && \
    curl -s https://raw.githubusercontent.com/titovanton/bicycle-docker/master/iptables/add_rules.sh > $file && \
    sudo /bin/bash $file && \
    rm $file

## Create Django-node

Create a brand new django-node image if you did not yet:

    sudo docker build -t \
        $USER/django-node:brand-new \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/Dockerfile

Launch container:

    sudo docker run -i -t --name django-myproject $USER/django-node:brand-new /bin/bash

Create Django project, do not forget change `PROJECT_NAME` and `EMAIL` variables:

    export PROJECT_NAME=myproject; \
    export EMAIL=mail@titovanton.com; \
    curl -s https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/create_project.sh | /bin/bash

## ElasticSearch-node

Prepare (set variables as you wish):

    REPO=$USER

Build image:

    sudo docker build --rm -t \
        $REPO/elasticsearch:brand-new \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/elasticsearch-node/Dockerfile

Run daemon container:

    sudo docker run -d \
        --name elasticsearch \
        $REPO/elasticsearch:brand-new

## Samba-node

Prepare (set variables as you wish):

    REPO=$USER && USERNAME=$USER && SHARE=/webapps; \

    sudo mkdir -p $SHARE && \
    sudo chown -R root:www-data $SHARE && \
    sudo chmod 775 $SHARE && \
    sudo adduser $USERNAME www-data

Build image:

    sudo docker build --rm -t \
        $REPO/samba:brand-new \
        https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/Dockerfile

Configure user:

    sudo docker run -t -i \
        --name samba-adduser \
        $REPO/samba:brand-new \
        /samba/create_user.sh $USERNAME && \
    sudo docker commit samba-adduser $REPO/samba:$USERNAME && \
    sudo docker rm samba-adduser

Run daemon container (set IP as you wish):

    # IP=$(ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}'); \

    sudo docker run -d \
        --name samba \
        -v /webapps:/webapps \
        -p 137:137/udp \
        -p 138:138/udp \
        -p 135:135/tcp \
        -p 139:139/tcp \
        -p 445:445/tcp \
        $REPO/samba:$USERNAME /samba/get_up.sh


## Automatically Start Containers

    file=$(mktemp) && \
    curl -s https://raw.githubusercontent.com/titovanton/bicycle-docker/master/auto_start.sh > $file && \
    sudo /bin/bash $file && \
    rm $file