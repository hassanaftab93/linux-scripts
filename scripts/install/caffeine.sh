#!/bin/bash

# Update apt and install dependencies
sudo add-apt-repository ppa:caffeine-developers/ppa
sudo apt update

# Install vagrant
sudo apt install caffeine -y
caffeine --version