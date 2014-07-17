#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage:"
    echo "export PROJECT_NAME=<project_name>"
    https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/create_project.sh
    echo '$ curl -s  /path/to/create_project.sh'
    exit 1
else
    PROJECT_NAME=$1
fi

# setting up uwsgi.ini from template (imperor mode)
if [ ! -f /etc/uwsgi/uwsgi_params ]; then
    cp /webapps/bicycle-docker/uwsgi_params /etc/uwsgi/uwsgi_params
fi
echo 'touch this file to reload vassal' > $PROJECT_DIR/reload_uwsgi
sed -e "s;%PROJECT_NAME%;$PROJECT_NAME;g" \
    /webapps/bicycle-docker/uwsgi.ini > /etc/uwsgi/uwsgi.ini
