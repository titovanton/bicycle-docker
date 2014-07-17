# bicycle-docker

## Install Docker

Ubuntu 14.04 LTS:

    curl -s https://get.docker.io/ubuntu/ | sudo sh

## Create Django-node

Create a brand new django-node image if you did not yet:

    sudo docker build -t $USER/django-node:brand-new https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/Dockerfile

Launch container:

    sudo docker run -i -t $USER/django-node:brand-new /bin/bash

Create Django project, do not forget rename `PROJECT_NAME` variable:

    export PROJECT_NAME=myproject
    curl -s  https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/create_project.sh | sudo bash
