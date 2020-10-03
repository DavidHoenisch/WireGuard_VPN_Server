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
apt install chkrootkit -y lynis -y qrencode -y git -y fail2ban -y

# this sections installs the packages needed for WireGuard to work
apt install apt-transport-https -y ca-certificates -y curl -y  gnupg-agent -y software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt update -y && apt install docker-ce -y docker-ce-cli -y containerd.io -y

curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# this section sets some perms and adds needed groups
chmod +x /usr/local/bin/docker-compose

usermod -aG docker admin

newgrp docker

# this section will set up a dir
mkdir /opt/wireguard-server

chown admin:admin /opt/wireguard-server

cat example.txt > /opt/wireguard-server/docker-compose.yaml # this section will need to have some file paths worked out

nano /opt/wireguard-server/docker-compose.yaml

cd /opt/wireguard-server

docker-compose up -d

