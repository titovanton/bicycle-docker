FROM ubuntu:base

MAINTAINER Titov Anton <mail@titovanton.com>


RUN apt-get -qqy install samba
RUN cp /etc/samba/smb.conf /etc/samba/smb.conf.default
RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/smb.conf" > /etc/samba/smb.conf
RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/create_user.sh" > /create_user.sh
RUN chmod +x /create_user.sh

VOLUME ["/data/"]

CMD ["/usr/sbin/smbd", "--foreground", "--log-stdout"]
