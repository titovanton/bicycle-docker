FROM ubuntu

MAINTAINER Titov Anton <mail@titovanton.com>

RUN apt-get -qq update
RUN apt-get -qqy upgrade

RUN apt-get -qqy install git
RUN apt-get -qqy install python2.7-dev
RUN apt-get -qqy install python-pip
RUN apt-get -qqy install libjpeg-dev
RUN pip install --upgrade pip
RUN apt-get -qqy install libpcre3
RUN apt-get -qqy install libpcre3-dev
RUN pip -q install uwsgi
RUN apt-get -qqy node-less
RUN apt-get -qqy imagemagick

# Источник: http://help.ubuntu.ru/wiki/iptables
RUN iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
RUN iptables -A INPUT -p icmp -j ACCEPT
RUN iptables -A INPUT -i lo -j ACCEPT
RUN iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m tcp --dport 22 -j ACCEPT
RUN iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m multiport --dports 80,443,8080 -j ACCEPT
RUN iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m multiport --dports 135,139,445 -j ACCEPT
RUN iptables -A INPUT -p udp -m conntrack --ctstate NEW -m multiport --dports 137,138 -j ACCEPT
RUN iptables -A INPUT -j REJECT --reject-with icmp-host-prohibited
RUN iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
RUN iptables -A FORWARD -p icmp -j ACCEPT
RUN iptables -A FORWARD -j REJECT --reject-with icmp-host-prohibited

RUN echo '#!/sbin/iptables-restore' > /etc/network/if-up.d/iptables-rules
RUN iptables-save >> /etc/network/if-up.d/iptables-rules
RUN chmod +x /etc/network/if-up.d/iptables-rules

