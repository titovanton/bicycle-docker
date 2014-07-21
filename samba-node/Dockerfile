FROM ubuntu:14.04

MAINTAINER Titov Anton <mail@titovanton.com>


RUN apt-get -qq update
RUN apt-get -qqy install samba
RUN apt-get -qqy install curl
RUN cp /etc/samba/smb.conf /etc/samba/smb.conf.default
RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/smb.conf" > /etc/samba/smb.conf
RUN mkdir -p /samba
RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/create_user.sh" > /samba/create_user.sh
RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/get_up.sh" > /samba/get_up.sh
RUN chmod +x /samba/create_user.sh
RUN chmod +x /samba/get_up.sh
