FROM titovanon/ubuntu

MAINTAINER Titov Anton <mail@titovanton.com>


RUN apt-get -qqy install postgresql-9.3
RUN apt-get -qqy install postgresql-server-dev-9.3
RUN apt-get -qqy install postgresql-contrib-9.3
RUN apt-get -qqy install redis-server
RUN apt-get -qqy install memcached

RUN mkdir /node
RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/postgresql-node/run.sh" > /node/run.sh
RUN chmod +x /node/run.sh

VOLUME ["/data/static", "/data/media", "/data/internal"]

# psql
EXPOSE 5432

# redis
EXPOSE 6379

# memcached
EXPOSE  11211

CMD ["/node/run.sh"]
