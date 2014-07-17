FROM ubuntu:14.04

MAINTAINER Titov Anton <mail@titovanton.com>

RUN apt-get -qq update

RUN apt-get -qqy install git
RUN apt-get -qqy install python2.7-dev
RUN apt-get -qqy install python-psycopg2
RUN apt-get -qqy install python-pip
RUN apt-get -qqy install libjpeg-dev
RUN apt-get -qqy install libpcre3
RUN apt-get -qqy install libpcre3-dev
RUN apt-get -qqy install node-less
RUN apt-get -qqy install imagemagick
RUN apt-get -qqy install curl
RUN apt-get -qqy install wget
RUN pip install --upgrade pip
RUN pip -q install uwsgi
