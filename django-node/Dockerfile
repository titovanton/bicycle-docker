FROM django:base

MAINTAINER Titov Anton <mail@titovanton.com>


RUN pip -q install python-memcached
RUN pip -q install django-extensions
RUN pip -q install django-debug-toolbar
RUN pip -q install django-debug-toolbar-template-timings
RUN pip -q install Werkzeug
RUN pip -q install South==0.8.4
RUN pip -q install django-grappelli==2.5.0
RUN pip -q install Pillow
RUN pip -q install Wand
RUN pip -q install git+git://github.com/mariocesar/sorl-thumbnail.git
RUN pip -q install redis
RUN pip -q install git+git://github.com/comoga/django-constance#egg=django-constance
RUN pip -q install cssmin
RUN pip -q install jsmin
RUN pip -q install git+git://github.com/titovanton-com/django-assets.git@stable

VOLUME ["/data/nginx", "/data/media", "/data/internal"]
