FROM ubuntu:base

MAINTAINER Titov Anton <mail@titovanton.com>


# git
RUN apt-get -qqy install git

# ssh
RUN apt-get -qqy install openssh-server
RUN mkdir -p /var/run/sshd
RUN echo 'root:1' |chpasswd

# python
RUN apt-get -qqy install build-essential
RUN apt-get -qqy install python2.7-dev
RUN apt-get -qqy install python-psycopg2
RUN apt-get -qqy install libjpeg-dev

# less
RUN apt-get -qqy install node-less

# imagemagick
RUN apt-get -qqy install imagemagick

# pip
RUN apt-get -qqy install python-pip
RUN pip -q install --upgrade pip
RUN pip -q install psycopg2

# uwsgi: install order is important
RUN apt-get -qqy install libpcre3
RUN apt-get -qqy install libpcre3-dev
RUN pip -q install uwsgi

# pip apps
RUN pip -q install Django

EXPOSE 22
EXPOSE 8000
