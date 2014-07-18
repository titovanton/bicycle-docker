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

    REPO=$USER && $USERNAME=$USER
    sudo docker build --rm -t $REPO/samba-node:brand-new https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/Dockerfile
    sudo docker run -t -i --name samba-adduser $REPO/samba-node:brand-new /setup/create_user.sh $USERNAME
    sudo docker commit samba-adduser $REPO/samba-node:$USERNAME
    sudo docker rm samba-adduser
    
Run:

    sudo docker run -d --name samba-node --volumes-from django-node -p 137:137/udp -p 138:138/udp -p 135:135/tcp -p 139:139/tcp -p 445:445/tcp $REPO/samba-node:$USERNAME
