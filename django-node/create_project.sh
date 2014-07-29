if [[ $# < 2 || ! $1 || ! $2 ]]; then
    echo "Two parameters are required: PROJECT_NAME, DB_PWD"
    exit 1
fi

PROJECT_NAME=$1
DB_PWD=$2
URL=https://raw.githubusercontent.com/titovanton/bicycle-docker/master/django-node

hostname $PROJECT_NAME
mkdir -p /data/django/$PROJECT_NAME
mkdir -p /data/static/$PROJECT_NAME
mkdir -p /data/media/$PROJECT_NAME
mkdir -p /data/internal/$PROJECT_NAME

# project_template
cd /
git clone https://github.com/titovanton/django-project.git

# Start Django project
cd /data/django/$PROJECT_NAME
django-admin.py startproject --template=/django-project --extension=py,txt,less $PROJECT_NAME .
sed -e "s;%DB_PWD%;$DB_PWD;g" \
    -i /data/django/$PROJECT_NAME/mainapp/settings/secret.py

# setting up uwsgi.ini from template
if [ ! -f /data/uwsgi/uwsgi_params ]; then
    curl -s "$URL/templates/uwsgi_params" > /data/uwsgi/uwsgi_params
fi
curl -s "$URL/templates/uwsgi.ini" > /data/uwsgi/$PROJECT_NAME.ini

# setting up nginx.conf from template
curl -s "$URL/templates/nginx.conf" > /data/nginx/sites-enabled/$PROJECT_NAME.conf

# deploy script
curl -s "$URL/templates/deploy.sh" \
    | sed -e "s;%PROJECT_NAME%;$PROJECT_NAME;g" > /data/django/$PROJECT_NAME/deploy.sh
chmod +x /data/django/$PROJECT_NAME/deploy.sh

# robots and favicon
curl -s "$URL/templates/favicon.ico" > /data/static/$PROJECT_NAME/favicon.ico
curl -s "$URL/templates/robots.txt" \
    | sed -e "s;%PROJECT_NAME%;$PROJECT_NAME;g" > /data/static/$PROJECT_NAME/robots.txt

# permissions
chown -R root:www-data /data/django/$PROJECT_NAME
chown -R root:www-data /data/static/$PROJECT_NAME
chown -R root:www-data /data/media/$PROJECT_NAME
chown -R root:www-data /data/internal/$PROJECT_NAME
