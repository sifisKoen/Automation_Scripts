#!/bin/sh

# Install Java
install_java(){

    printf "   ___                  
              |_  |                 
                | | __ ___   ____ _ 
                | |/ _  \ \ / / _  |
            /\__/ / (_| |\ V / (_| |
            \____/ \__,_| \_/ \__,_|
    \n" >&2
    
    echo "Installing Java..."    
    sudo apt update
    sudo apt install default-jdk default-jre -y
    sudo java -version

}

create_hadoop_user(){
    
    printf " 
           _   _               
          | | | |              
          | | | |___  ___ _ __ 
          | | | / __|/ _ \ '__|
          | |_| \__ \  __/ |   
           \___/|___/\___|_|   \n" >&2
    

    printf "Do you want to create new user to install Hadoop? (yes/no): " >&2
    read -r choice

    if [ "$choice" = "yes" ] || [ "$choice" = "y" ]; then

        printf "Please enter the new username: " >&2
        read -r new_user_name
        user_home="/opt/$new_user_name"
        echo "Creating hadoop user..." >&2
        sudo useradd -r "$new_user_name" -m -d "$user_home" --shell /bin/bash

        # Set a new password
        echo "Add password for hadoop user" >&2
        sudo passwd "$new_user_name"
    else
        new_user_name=$(whoami)
        user_home="$HOME"
    fi

    echo "$new_user_name $user_home"
        
}

generate_new_ssh_key(){

    user="$1"
    home_dir="$2"
    
    printf " 
          _____ _____ _   _ 
          /  ___/  ___| | | |
          \  --.\  --.| |_| |
            --. \`--. \  _  |
          /\__/ /\__/ / | | |
          \____/\____/\_| |_/ \n" >&2

    # Generate ssh keys for hadoop user and set up local ssh
    echo "Setting up SSH for $user..."
    sudo -u "$user" ssh-keygen -t rsa -f "$home_dir/.ssh/id_rsa" -N ""
    sudo -u "$user" sh -c "cat $home_dir/.ssh/id_rsa.pub > $home_dir/.ssh/authorized_keys"
    # sudo -u hadoop ssh-keyscan localhost >> /opt/hadoop/.ssh/known_hosts

}


downlaod_and_extract_hadoop(){
    
    user="$1"
    home_dir="$2"
    printf "
           _   _           _                   
          | | | |         | |                  
          | |_| | __ _  __| | ___   ___  _ __  
          |  _  |/ _  |/ _  |/ _ \ / _ \| '_ \ 
          | | | | (_| | (_| | (_) | (_) | |_) |
          \_| |_/\__,_|\__,_|\___/ \___/| .__/ 
                                      | |    
                                      |_|   \n" >&2

    # Download and extract Hadoop for hadoop user
    echo "Downloading and extracting Hadoop..."
    sudo -u "$user" wget https://dlcdn.apache.org/hadoop/common/hadoop-3.2.4/hadoop-3.2.4.tar.gz -O "$home_dir/hadoop-3.2.4.tar.gz"
    sudo -u "$user" tar -xzvf "$home_dir/hadoop-3.2.4.tar.gz" -C "$home_dir" --strip-components=1

}

configure_hadoop_environment(){

    user="$1"
    home_dir="$2"

    # Add environment variables to hadoop's bashrc
sudo -u "$user" bash -c "cat >> $home_dir/.bashrc" <<EOL
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export HADOOP_HOME=$home_dir
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

main(){

    create_hadoop_user | {
        read -r user user_home
        generate_new_ssh_key "$user" "$user_home"
        install_java
        downlaod_and_extract_hadoop "$user" "$user_home"
        configure_hadoop_environment "$user" "$user_home"
        echo "Hadoop setup complete for $user !"
    }    
    
}

main