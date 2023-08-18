#!/bin/bash

# Update apt and install dependencies
sudo apt update
sudo apt install wget gconf-service gconf2-common libc++1 libc++1-14 libc++abi1-14 libgconf-2-4 libunwind-14 -y

# wget Discord
cd ~/Downloads
wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb

# Install Discord
sudo dpkg -i discord.deb