FROM ubuntu:14.04

MAINTAINER Titov Anton <mail@titovanton.com>


RUN apt-get -qq update
RUN apt-get -qqy install samba
RUN apt-get -qqy install curl
RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/smb.conf" > /etc/samba/smb.conf