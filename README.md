# bicycle-docker

## Install Docker

Ubuntu 14.04 LTS:

    curl -s https://get.docker.io/ubuntu/ | sudo sh

## Create Django-node

Create a brand new django-node image if you did not yet:

    sudo docker build -t $USER/django-node:brand-new https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/Dockerfile

Launch container:

    sudo docker run -i -t --name django-myproject $USER/django-node:brand-new /bin/bash

Create Django project, do not forget change `PROJECT_NAME` and `EMAIL` variables:

    export PROJECT_NAME=myproject; \
    export EMAIL=mail@titovanton.com; \
    curl -s  https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/create_project.sh | /bin/bash
