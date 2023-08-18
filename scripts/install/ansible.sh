#!/bin/bash

# Update apt and install dependencies
sudo apt update
sudo apt install software-properties-common

# Add repository
sudo apt-add-repository --yes --update ppa:ansible/ansible

# Install Ansible
sudo apt install ansible -y
ansible --version