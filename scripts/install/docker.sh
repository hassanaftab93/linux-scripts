#!/bin/bash

# Update apt and install dependencies
sudo apt update

# Install Docker
sudo apt install -y docker.io

# Enable Docker
sudo systemctl enable docker --now

docker

# Give user permission
sudo usermod -aG docker $USER