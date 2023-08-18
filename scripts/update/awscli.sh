#!/bin/bash

# Update apt and install dependencies
sudo apt update

# Install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/bin --install-dir /usr/bin/aws-cli --update
aws --version

# Remove downloaded files
rm -rf aws
rm -rf awscliv2.zip

# Configure AWS Account here
aws configure