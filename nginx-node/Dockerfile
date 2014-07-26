FROM ubuntu:base

MAINTAINER Titov Anton <mail@titovanton.com>


RUN apt-get -qqy install nginx

RUN sed -e "s/# server_names_hash_bucket_size 64/server_names_hash_bucket_size 64/g" -i /etc/nginx/nginx.conf
RUN sed -e "s;/etc/nginx/sites-enabled/\*;/data/nginx/*;g" -i /etc/nginx/nginx.conf

VOLUME ["/data/nginx/"]

CMD ["/etc/init.d/nginx", "start"]
