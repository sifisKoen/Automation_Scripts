#!/bin/sh

# Ask user for a name for the hadoop user
printf "Enter the name for the Hadoop user: "
read -r hadoop_user_name

# Add user
sudo useradd -r "$hadoop_user_name" -m -b /opt/hadoop --shell /bin/bash

# Ask user for a password for the new hadoop user
echo "Pleas enter a password for the $hadoop_user_name user: "
read -r hadoop_user_password
echo

# Set the password for the hadoop user
echo "$hadoop_user_name:$hadoop_user_password" | sudo chpasswd


# Generate SSH key and add to authorized_keys
sudo -u hadoop sh -c '
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
'

# Install Java
sudo apt update
sudo apt install default-jdk default-jre -y
sudo java -version

# Download Hadoop
sudo -u "$hadoop_user_name" wget https://www.apache.org/dyn/closer.cgi/hadoop/common/hadoop-3.2.4/hadoop-3.2.4.tar.gz -O hadoop-3.2.4.tar.gz

# Append environment variables to hadoop user .bashrc file
sudo -u "$hadoop_user_name" bash -c 'cat >> ~/.bashrc' <<EOL
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
