if [[ $repo == '' ]]; then
    echo 'Repo can not be blank'
    exit 1
fi
if [[ $USER_NAME == '' ]]; then
    echo 'User name can not be blank'
    exit 1
fi
docker build --rm -t $repo/samba-node:brand-new https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/Dockerfile
docker run -t -i --name samba-adduser $repo/samba-node:brand-new /tmp/create_user.sh $USER_NAME
docker commit samba-adduser $repo/samba-node:$USER_NAME
docker rm samba-adduser
