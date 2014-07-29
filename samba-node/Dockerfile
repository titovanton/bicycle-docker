FROM ubuntu:base

MAINTAINER Titov Anton <mail@titovanton.com>


RUN apt-get -qqy install samba
RUN cp /etc/samba/smb.conf /etc/samba/smb.conf.default
RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/smb.conf" > /etc/samba/smb.conf
RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/create_user.sh" > /create_user.sh
RUN chmod +x /create_user.sh
RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/run.sh" > /run.sh
RUN chmod +x /run.sh

VOLUME ["/data/"]

EXPOSE 137/udp
EXPOSE 138/udp
EXPOSE 135/tcp
EXPOSE 139/tcp
EXPOSE 445/tcp

CMD ["/usr/sbin/smbd", "--foreground", "--log-stdout"]
