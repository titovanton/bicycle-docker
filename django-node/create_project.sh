if [[ ! $PROJECT_NAME || ! $EMAIL ]]; then
    echo "Usage:"
    echo "export PROJECT_NAME=myproject"
    echo "export EMAIL=mail@titovanton.com"
    echo "curl -s https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node/create_project.sh | sudo -E bash"
    exit 1
fi


if [ ! -f /root/.ssh/id_rsa ]; then
    if [[ $EMAIL == '' ]]; then
        EMAIL=mail@titovanton.com
    fi
    mkdir -p /root/.ssh
    cd /root/.ssh
    ssh-keygen -t rsa -C "$EMAIL"
    eval `ssh-agent -s`
    ssh-add /root/.ssh/id_rsa
fi

# uwsgi
if [ ! -f /etc/uwsgi/uwsgi_params ]; then
    curl -s https://raw.githubusercontent.com/nginx/nginx/master/conf/uwsgi_params > /etc/uwsgi/uwsgi_params
fi
echo 'touch this file to reload vassal' > $PROJECT_DIR/reload_uwsgi
sed -e "s;%PROJECT_NAME%;$PROJECT_NAME;g" \
    /webapps/bicycle-docker/uwsgi.ini > /etc/uwsgi/uwsgi.ini
