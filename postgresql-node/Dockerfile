FROM ubuntu:14.04

MAINTAINER Titov Anton <mail@titovanton.com>


RUN apt-get -qq update
RUN apt-get -qqy install curl
RUN apt-get -qqy install postgresql-9.3
RUN apt-get -qqy install postgresql-server-dev-9.3
RUN apt-get -qqy install postgresql-contrib-9.3
RUN apt-get -qqy install redis-server
RUN apt-get -qqy install memcached

RUN mkdir /run
RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/postgresql-node/run.sh" > /run/.sh
RUN chmod +x /run/.sh

VOLUME ["/data/static", "/data/media", "/data/internal"]

# psql
EXPOSE 5432

# redis
EXPOSE 6379

# memcached
EXPOSE  11211

CMD ["/run/.sh"]
