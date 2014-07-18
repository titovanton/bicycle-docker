read -p "Enter name of samba user (required): " USER_NAME
if [[ $USER_NAME == '' ]]; then
    echo 'User name can not be blank'
    exit 1
fi
docker build -t $user/samba-node:brand-new https://raw.githubusercontent.com/titovanton/bicycle-docker/master/samba-node/Dockerfile
last=$(sudo docker ps -l -q)
docker run -t -i $last "useradd --no-log-init --no-create-home --no-user-group $USER_NAME; smbpasswd -a $USER_NAME; smbpasswd -e $USER_NAME"
last=$(sudo docker ps -l -q)
docker commit $last $user/samba-node:$USER_NAME