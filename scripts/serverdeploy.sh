#!/bin/bash

# this section check for root privs
if [[ $UID -ne 0 ]];
    then 
        echo "Please run as sudo!"
exit
fi

# this section updates the system
apt update -y && apt upgrade -y && apt autoremove -y 

# this section installs the needed admin tools
apt install chkrootkit lynis qrencode git vim

# this sections installs the packages needed for WireGuard to work
apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt update && apt install docker-ce docker-ce-cli containerd.io

curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# this section sets some perms and adds needed groups
chmod +x /usr/local/bin/docker-compose

usermod -aG docker $USER

newgrp docker

# this section will set up a dir
mkdir /opt/wireguard-server

chown $USER:$USER /opt/wireguard-server

cat example.txt > /opt/wireguard-server/docker-compose.yaml # this section will need to have some file paths worked out

exit

vim /opt/wireguard-server/docker-compose.yaml

cd /opt/wireguard-server

docker-compose up -d

