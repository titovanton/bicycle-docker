FROM ubuntu:base

MAINTAINER Titov Anton <mail@titovanton.com>

ENV POSTGRES_VERSION 9.3

RUN apt-get -qqy install postgresql-$POSTGRES_VERSION
RUN apt-get -qqy install postgresql-server-dev-$POSTGRES_VERSION
RUN apt-get -qqy install postgresql-contrib-$POSTGRES_VERSION
RUN apt-get -qqy install openssl
RUN apt-get -qqy install libssl-dev
RUN apt-get -qqy install redis-server
RUN apt-get -qqy install memcached

RUN sed -e "s/#.*\(listen_addresses.*=.*'\)localhost'/\1*'/" \
    -i /etc/postgresql/$POSTGRES_VERSION/main/postgresql.conf
RUN sed -e "s/\(command line switches\.\)/\1\n\nhost all all 0.0.0.0\/0 md5/" \
    -i /etc/postgresql/9.1/main/pg_hba.conf

RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/postgresql-node/run.sh" > /run.sh
RUN chmod +x /run.sh

VOLUME ["/data/static/", "/data/media/", "/data/internal/"]

# psql
EXPOSE 5432

# redis
EXPOSE 6379

# memcached
EXPOSE  11211

CMD ["/run.sh"]
