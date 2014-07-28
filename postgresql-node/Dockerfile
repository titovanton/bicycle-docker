FROM postgres:base

MAINTAINER Titov Anton <mail@titovanton.com>


RUN sed -e "s/#.*\(listen_addresses.*=.*'\)localhost'/\1*'/" \
    -i /etc/postgresql/$POSTGRES_VERSION/main/postgresql.conf
RUN sed -e "s/\(command line switches\.\)/\1\n\nhost all all 0.0.0.0\/0 md5/" \
    -i /etc/postgresql/$POSTGRES_VERSION/main/pg_hba.conf

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
