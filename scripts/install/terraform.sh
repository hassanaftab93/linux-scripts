#!/bin/bash

# Update apt and install dependencies
sudo apt update
sudo apt install -y software-properties-common
apt install -y gnupg

# Install the HashiCorp GPG key.
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Verify Key's Fingerprint
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

# Add the official Hashicorp repo to system
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

# Download package info from Hashicorp
sudo apt update

# Install Terraform
sudo apt install terraform -y
terraform -help