FROM ubuntu:14.04

MAINTAINER Titov Anton <mail@titovanton.com>


RUN apt-get -qq update
RUN apt-get -qqy install curl
RUN apt-get -qqy install openjdk-7-jre-headless
RUN mkdir -p /elasticsearch
RUN curl -s -o /elasticsearch/elasticsearch-1.1.1.deb \
    https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.deb
RUN dpkg -i /elasticsearch/elasticsearch-1.1.1.deb
RUN /usr/share/elasticsearch/bin/plugin \
    -install analysis-morphology \
    -url http://dl.bintray.com/content/imotov/elasticsearch-plugins/org/elasticsearch/elasticsearch-analysis-morphology/1.2.0/elasticsearch-analysis-morphology-1.2.0.zip
RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/elasticsearch-node/get_up.sh" > /elasticsearch/get_up.sh
RUN chmod +x /samba/get_up.sh
