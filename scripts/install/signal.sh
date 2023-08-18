#!/bin/bash

# Update apt and install dependencies
sudo apt update

# Install gpg key
wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -

# Add Signal Repo
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# Install Signal
sudo apt update
sudo apt install signal-desktop -y