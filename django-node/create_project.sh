if [[ $# < 2 || ! $1 || ! $2 ]]; then
    echo "Two parameters are required: PROJECT_NAME, DB_PWD"
    exit 1
fi

PROJECT_NAME=$1
DB_PWD=$2

# Start Django project
django-admin.py startproject --template=$PROJECT_TEMPLATE --extension=py,txt,less $PROJECT_NAME .
sed -e "s;%DB_PWD%;$DB_PWD;g" \
    -i /data/django/$PROJECT_NAME/mainapp/settings/secret.py
