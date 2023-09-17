#!/bin/sh

# Create a function to set a new password for our new user
set_user_password(){
    user_name="$1"

    while true ; do
        
        printf "Please enter a passowrd for %s user: " "$user_name"
        read -r new_user_password
        echo

        printf "Please re-enter the password for %s user. For confirmation: " "$user_name"
        read -r confirm_password
        echo

        if [ "$new_user_password" = "$confirm_password" ]; then
            echo "$user_name:$new_user_password" | sudo chpasswd
            break
        else
            echo "Password do not match. Please try again."
        fi
        
    done

}

# Create a function to generate SSH key for the user
generate_new_ssh_key(){

    user_name="$1"

    # Generate SSH key and add to authorized_keys
    sudo -u hadoop sh -c '
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
    cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
    '

}

# Create a function to install Java
install_java(){

    sudo apt update
    sudo apt intall default-jdk default-jre -y
    sudo hava -version
}


install_hadoop(){

    user_name="$1"

    sudo -u "$user_name" wget https://www.apache.org/dyn/closer.cgi/hadoop/common/hadoop-3.2.4/hadoop-3.2.4.tar.gz -O hadoop-3.2.4.tar.gz

    sudo -u "$user_name" sh -c 'cat >> ~/.bashrc' <<EOL
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export HADOOP_HOME=/opt/hadoop
export PATH=\$PATH:\$HADOOP_HOME/bin
export PATH=\$PATH:\$HADOOP_HOME/sbin
export HADOOP_MAPRED_HOME=\$HADOOP_HOME
export HADOOP_COMMON_HOME=\$HADOOP_HOME
export HADOOP_HDFS_HOME=\$HADOOP_HOME
export YARN_HOME=\$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=\$HADOOP_HOME/lib"
EOL
}


printf "Do you want to create a user for Hadoop? (yea/no): "
read -r user_response

if [ "$user_response" = "yes" ] || [ "$user_response" = "y" ]; then
    printf "Enter the name for the Hadoop user: "
    read -r hadoop_user_name

    sudo useradd -r "$hadoop_user_name" -m -b /opt/hadoop --shell /bim/bash

    set_user_password "$hadoop_user_name"
    generate_new_ssh_key "$hadoop_user_name"
    install_java
    install_hadoop "$hadoop_user_name"

else
    printf "Do you want to install Hadoop on your current user? (yes/no): "
    read -r user_response_2

    if [ "$user_response_2" = "yes" ] || [ "$user_response_2" = "y" ]; then
        current_user=$(whoami)
        generate_new_ssh_key "$current_user"
        install_java
        install_hadoop "$current_user"
    else
        echo "Exiting ..."
        exit 0
    fi
fi

