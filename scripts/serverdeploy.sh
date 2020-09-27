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
sudo apt install chkrootkit lynis qrencode curl git vim

# this sections installs the packages needed for WireGuard to work
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose


# this section sets some perms and adds needed groups
sudo chmod +x /usr/local/bin/docker-compose

sudo usermod -aG docker $USER

newgrp docker

# this section will set up a dir
sudo mkdir /opt/wireguard-server

sudo chown $USER:$USER /opt/wireguard-server

cat example.txt > /opt/wireguard-server/docker-compose.yaml # this section will need to have some file paths worked out

vim /opt/wireguard-server/docker-compose.yaml

cd /opt/wireguard-server

docker-compose up -d

