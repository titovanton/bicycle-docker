FROM django:base

MAINTAINER Titov Anton <mail@titovanton.com>


RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/run.sh" > /run.sh
RUN chmod +x /run.sh
RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/create_project.sh" > /create_project.sh
RUN chmod +x /create_project.sh

VOLUME ["/data/uwsgi/run/", "/data/uwsgi/log/"]
