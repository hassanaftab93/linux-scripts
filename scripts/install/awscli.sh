#!/bin/bash

# Update apt and install dependencies
sudo apt update

# Install aws cli
sudo apt install -y awscli
aws --version

# Configure AWS Account here
aws configure