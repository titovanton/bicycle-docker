FROM ubuntu:14.04

MAINTAINER Titov Anton <mail@titovanton.com>


RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get -qq update
RUN apt-get -qq upgrade
RUN apt-get -qq build-essential
RUN apt-get -qq software-properties-common
RUN apt-get -qqy install curl
