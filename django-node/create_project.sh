if [[ $# -ne 1 ]]; then
    echo "Usage:"
    echo "export PROJECT_NAME=<project_name>"
    echo "curl -s https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/create_project.sh | sudo sh"
    exit 1
fi

# uwsgi
if [ ! -f /etc/uwsgi/uwsgi_params ]; then
    curl -s https://raw.githubusercontent.com/nginx/nginx/master/conf/uwsgi_params > /etc/uwsgi/uwsgi_params
fi
echo 'touch this file to reload vassal' > $PROJECT_DIR/reload_uwsgi
sed -e "s;%PROJECT_NAME%;$PROJECT_NAME;g" \
    /webapps/bicycle-docker/uwsgi.ini > /etc/uwsgi/uwsgi.ini
