#!/bin/sh

# Java installation

error_handle(){
    if [ $? -ne 0 ]; then
        echo "An error occured. The script stoped"
        exit 1
    fi
}

# Install wtf repository so to be able to install older versions for java in Debian 12 systems  
install_wtf_repository(){

    printf " 
     _    _ ___________  ______ ___________ _____ 
    | |  | |_   _|  ___| | ___ \  ___| ___ \  _  |
    | |  | | | | | |_    | |_/ / |__ | |_/ / | | |
    | |/\| | | | |  _|   |    /|  __||  __/| | | |
    \  /\  / | | | |     | |\ \| |___| |   \ \_/ /
     \/  \/  \_/ \_|     \_| \_\____/\_|    \___/ 
                                              
    \n" >&2
    
    # Check if the wtf repo is not already added 
    if ! grep -q "wtf-bookworm.sources" /etc/apt/sources.list.d/* 2>/dev/null; then
        wget http://www.mirbsd.org/~tg/Debs/sources.txt/wtf-bookworm.sources
        error_handle
        sudo mkdir -p /etc/apt/sources.list.d
        sudo mv wtf-bookworm.sources /etc/apt/sources.list.d/
        sudo apt update
        error_handle
    fi
}

java_install(){

    printf "   ___                  
              |_  |                 
                | | __ ___   ____ _ 
                | |/ _  \ \ / / _  |
            /\__/ / (_| |\ V / (_| |
            \____/ \__,_| \_/ \__,_|
    \n" >&2
    
    sudo apt install openjdk-8-jdk
    error_handle

}

install_cassandra(){

    printf " 
     _____                               _           
    /  __ \                             | |          
    | /  \/ __ _ ___ ___  __ _ _ __   __| |_ __ __ _ 
    | |    / _ / __/ __|/  _  |  _ \ / _  |  __/ _  |
    | \__/\ (_| \__ \__ \ (_| | | | | (_| | | | (_| |
     \____/\__,_|___/___/\__,_|_| |_|\__,_|_|  \__,_|
                                                 
    \n" >&2


    if ! grep -q "debian.cassandra.apache.org" /etc/apt/sources.list.d/* 2>/dev/null; then
        echo "deb https://debian.cassandra.apache.org 41x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
        error_handle

        # Add the Apache Cassandra repository keys to the list of trusted keys on your machine    
        curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -
        error_handle
        sudo apt-get update
        error_handle
    fi

    # Install Cassandra
    sudo apt install cassandra -y
    error_handle

}

final_output(){

    status_command="nodetool status"
    connect_command="cqlsh"

    echo "-------------------------------------------------------------------------"
    printf "\nRun '%s' command so to check the status of your Cassandra db !\n", "$status_command"
    printf "Run '%s' command so to connect to your Cassandra db !", "$connect_command"
    echo "-------------------------------------------------------------------------"
}

main(){

    echo "Installing dependencies..."
    sudo apt install -y curl wget
    error_handle

    install_wtf_repository
    java_install
    install_cassandra

    final_output
}

main