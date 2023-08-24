#!/bin/bash

# Update apt and install dependencies
cd ~/Downloads
sudo apt update
sudo apt install apt-transport-https

# Install the GPG key:
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null

# Choose stable channel
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Install sublime merge
sudo apt update
sudo apt install sublime-merge