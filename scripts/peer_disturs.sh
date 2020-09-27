#!/bin/bash

# this script is to make the distpursment of peer config files more streamlined

# this section checks for root privs.  As the config files live in the root dir sudo will be needed
if [[ $UID -ne 0 ]];
    then 
        echo "Please run with sudo!"
    exit
fi

# this section offers choices 

menu () {

    echo "[1] Connect mobile clients"
    echo "[2] Connect computers with scp"
    echo "[3] Connect computers with copy & paste"
    echo "[4] Exit"
    echo " "
        read -p "Please choose a menu opion (1, 2, etc.): " choice
    echo " "
sleep 1s

}

# this section defines choice functions
choice_one () {

        ls /opt/wireguard-server/config/
        read -p "What profile would  you like to use(example: peer1)? " profile 
            qrencode -t ansiutf8 < /opt/wireguard-server/config/$profile/*.conf

menu 

}

choice_two () {

        ls /opt/wireguard-server/config/
        read -p "What profile would  you like to use(example: peer1)? " profile 
        echo " "
        read -p "What is your computers IP?: " IP
        echo " "
        read -p "What is your User ID?: " user
        echo " "
        read -p "What the file path?: " path
        echo " "
            echo "please verify the information you provided: "
            echo " "
            echo $profile
            echo " "
            echo $IP
            echo " "
            echo $user
            echo " "
            echo $path 
            echo " "
            read -p "Is the information correct(y/n)? " correct
                if [[ $correct == "y" ]];
                    then 
                        scp /opt/wireguard-server/config/$profile $user@$IP:$path
                            if [[ $? -ne 0 ]];
                                then 
                                    echo "An unknown error occured"
                                    sleep 1s
                                    echo " "
                                    echo "Please check your firewall rules and network configurations and try again"
                            fi
                else
                echo " "
                    choice_one 
                fi
menu 

}

choice_three () {

    ls /opt/wireguard-server/config/
    read -p "What profile would  you like to use(example: peer1)? " profile 
        cat /opt/wireguard-server/config/$profile/*.conf
menu 

}

choice_four () {

    exit 

}


# this section calls f(x)'s based on user input

 if [[ $choice == "1" ]];
    then
        choice_one 
fi

if [[ $choice == "2" ]];
    then 
        choice_two 
fi 

if [[ $choice == "3" ]];
    then
        choice_three 
fi

if [[ $choice == "4" ]];
    then 
        choice_four 
fi

