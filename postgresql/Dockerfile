FROM ubuntu:base

MAINTAINER Titov Anton <mail@titovanton.com>

ENV POSTGRES_VERSION 9.3

RUN apt-get -qqy install postgresql-$POSTGRES_VERSION
RUN apt-get -qqy install postgresql-server-dev-$POSTGRES_VERSION
RUN apt-get -qqy install postgresql-contrib-$POSTGRES_VERSION
RUN apt-get -qqy install postgresql-client
RUN apt-get -qqy install openssl
RUN apt-get -qqy install libssl-dev
RUN apt-get -qqy install redis-server
RUN apt-get -qqy install memcached