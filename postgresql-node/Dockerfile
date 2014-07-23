FROM ubuntu:14.04

MAINTAINER Titov Anton <mail@titovanton.com>

RUN apt-get -qqy install postgresql-9.3
RUN apt-get -qqy install postgresql-server-dev-9.3
RUN apt-get -qqy install postgresql-contrib-9.3
RUN apt-get -qqy install redis-server
RUN apt-get -qqy install memcached

VOLUME ["/data"]

RUN mkdir -p /data/static /data/media /data/internal
RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/postgresql-node/run.sh" > /data/run.sh
RUN chmod +x /data/run.sh

# psql
EXPOSE 5432

# redis
EXPOSE 6379

# memcached
EXPOSE  11211

CMD ["/postgres/run.sh"]
