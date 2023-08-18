#!/bin/bash

# Update apt and install dependencies
sudo apt update
sudo apt install virtualbox -y

# Install vagrant
sudo apt install vagrant -y
vagrant --version