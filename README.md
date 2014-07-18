# bicycle-docker

## Install Docker

Ubuntu 14.04 LTS:

    curl https://get.docker.io/ubuntu/ | sudo sh

## Create Django-node

Create a brand new django-node image if you did not yet:

    sudo docker build -t $USER/django-node:brand-new https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/Dockerfile

Launch container:

    sudo docker run -i -t --name django-myproject $USER/django-node:brand-new /bin/bash

Create Django project, do not forget change `PROJECT_NAME` and `EMAIL` variables:

    export PROJECT_NAME=myproject; \
    export EMAIL=mail@titovanton.com; \
    curl https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/create_project.sh | /bin/bash

## Samba-node

Setup (set variables as you wish):

    REPO=$USER && USERNAME=$USER; \
    sudo docker build --rm -t $REPO/samba-node:brand-new https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/Dockerfile; \
    sudo docker run -t -i --name="samba-adduser" $REPO/samba-node:brand-new /setup/create_user.sh $USERNAME; \
    sudo docker commit samba-adduser $REPO/samba-node:tmp; \
    sudo docker rm samba-adduser; \
    sudo docker run -d --name="samba-node" --volumes-from django-node -p 192.168.1.4:137:137/udp -p 192.168.1.4:138:138/udp -p 192.168.1.4:135:135/tcp -p 192.168.1.4:139:139/tcp -p 192.168.1.4:445:445/tcp $REPO/samba-node:tmp smbd -F -S; \
    sudo docker commit samba-node $REPO/samba-node:$USERNAME; \
    sudo docker stop samba-node; \
    sudo docker rm samba-node; \
    sudo docker rmi $REPO/samba-node:tmp; \
    sudo docker run -d --name="samba-node" $REPO/samba-node:$USERNAME

Run:

    sudo docker run -d --name samba-node --volumes-from django-node -p 137:137/udp -p 138:138/udp -p 135:135/tcp -p 139:139/tcp -p 445:445/tcp $REPO/samba-node:$USERNAME
