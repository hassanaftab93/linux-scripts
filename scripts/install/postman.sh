#!/bin/bash

# Update apt and install dependencies
sudo apt update

# Download Postman by running following command in your Linux system:
cd ~/Downloads
wget https://dl.pstmn.io/download/latest/linux64 -O postman-linux-x64.tar.gz

# Extract the downloaded file by running the following command in /opt directory:
sudo tar -xvzf postman-linux-x64.tar.gz -C /opt

# Finally, create a symbolic link running following command in terminal:
sudo ln -s /opt/Postman/Postman /usr/bin/postman