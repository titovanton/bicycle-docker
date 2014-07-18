if [[ $repo == '' ]]; then
    echo 'Repo can not be blank'
    exit 1
fi
if [[ $USER_NAME == '' ]]; then
    echo 'User name can not be blank'
    exit 1
fi
id=$(docker build --rm -t $repo/samba-node:brand-new https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/Dockerfile)
# docker run -t -i $id "useradd --no-log-init --no-create-home --no-user-group $USER_NAME && smbpasswd -a $USER_NAME && smbpasswd -e $USER_NAME"
# id=$(sudo docker ps -l -q)
# docker commit $id $repo/samba-node:$USER_NAME
# docker rm $id
echo "ID: $id"