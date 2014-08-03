FROM ubuntu:base

MAINTAINER Titov Anton <mail@titovanton.com>


RUN add-apt-repository -qqy ppa:nginx/stable
RUN apt-get -qq update
RUN apt-get -qqy install nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# sites-enabled and logs
RUN sed -e "s;/etc\(/nginx/sites-enabled/\*\);/data\1;g" -i /etc/nginx/nginx.conf
RUN sed -e "s;/var/log/nginx/;/data/nginx/log/;g" -i /etc/nginx/nginx.conf

# server_names_hash_bucket_size
RUN sed -e "s/# \(server_names_hash_bucket_size 64\)/\1/g" -i /etc/nginx/nginx.conf

# gzip
RUN sed -e "s/# \(gzip_vary\)/\1/g" -i /etc/nginx/nginx.conf
RUN sed -e "s/# \(gzip_proxied\)/\1/g" -i /etc/nginx/nginx.conf
RUN sed -e "s/# \(gzip_comp_level\)/\1/g" -i /etc/nginx/nginx.conf
RUN sed -e "s/# \(gzip_buffers\)/\1/g" -i /etc/nginx/nginx.conf
RUN sed -e "s/# \(gzip_http_version\)/\1/g" -i /etc/nginx/nginx.conf
RUN sed -e "s/# \(gzip_types\)/\1/g" -i /etc/nginx/nginx.conf

VOLUME ["/data/nginx/sites-enabled", "/data/nginx/log"]

CMD ["/usr/sbin/nginx"]

EXPOSE 80
EXPOSE 443
EXPOSE 8000