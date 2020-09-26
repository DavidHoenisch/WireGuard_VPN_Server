#!/bin/bash

# this script is to make the distpursment of peer config files more streamlined

# this section checks for root privs.  As the config files live in the root dir sudo will be needed
if [[ $UID -ne 0 ]]:
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
if [[ $choice == "1" ]];
    then
        ls /opt/wireguard-server/config/
        read -p "What profile would  you like to use(example: peer1)? " profile 
            qrencode -t ansiutf8 < $profile*
fi
menu ()
}


choice_two () {
if [[ $choice == "2" ]];
    then
        ls /opt/wireguard-server/config/
        read -p "What profile would  you like to use(example: peer1)? " profile 
        read -p "What is your computers IP?: " IP
        read -p "What is your User ID?: " user
        read -p "What the file path?: " path
            echo "please verify the information you provided: "
            echo $profile
            echo $IP
            echo $user
            echo $path 
            read -p "Is the information correct(y/n)? " correct
                if [[ $correct == "y" ]];
                    then 
                        scp $profile* $user@$IP:$path
                            if [[ $? -ne 0 ]];
                                then 
                                    echo "An unknown error occured"
                                    sleep 1s
                                    echo "Please check your firewall rules and network configurations and try again"
                            fi
                else ;
                    choice_one ()
                fi
menu ()
fi
}

choice_three () {
    ls /opt/wireguard-server/config/
    read -p "What profile would  you like to use(example: peer1)? " profile 
        cat /opt/wireguard-server/config/$profile
menu ()    
}

choice_four () {
    exit ()
}


# this section calls f(x)'s based on user input

 if [[ $choice == "1" ]];
    then
        choice_one () 
fi

if [[ $choice == "2" ]];
    then 
        choice_two ()
fi 

if [[ $choice == "3" ]];
    then
        choice_three ()
fi

if [[ $choice == "4" ]];
    then 
        choice_four ()
fi

