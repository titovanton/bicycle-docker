FROM django:base

MAINTAINER Titov Anton <mail@titovanton.com>


# RUN pip -q install python-memcached
# RUN pip -q install django-extensions
# RUN pip -q install django-debug-toolbar
# RUN pip -q install django-debug-toolbar-template-timings
# RUN pip -q install Werkzeug
# RUN pip -q install South==0.8.4
# RUN pip -q install django-grappelli==2.5.0
# RUN pip -q install Pillow
# RUN pip -q install Wand
# RUN pip -q install git+git://github.com/mariocesar/sorl-thumbnail.git
# RUN pip -q install redis
# RUN pip -q install git+git://github.com/comoga/django-constance#egg=django-constance
# RUN pip -q install cssmin
# RUN pip -q install jsmin
# RUN pip -q install git+git://github.com/titovanton-com/django-assets.git@stable

RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/run.sh" > /run.sh
RUN chmod +x /run.sh
RUN curl -s "https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/create_project.sh" > /create_project.sh
RUN chmod +x /create_project.sh

VOLUME ["/data/uwsgi/run/", "/data/uwsgi/log/",]
