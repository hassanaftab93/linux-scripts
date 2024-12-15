#!/bin/bash

# Install curl
sudo apt update
cd ~/Downloads/
curl -o terragrunt -L https://github.com/gruntwork-io/terragrunt/releases/download/v0.69.13/terragrunt_linux_amd64
chmod u+x terragrunt
sudo mv terragrunt /usr/local/bin/terragrunt