#!/bin/bash

# Update apt and install dependencies
sudo apt update
sudo apt install -y ca-certificates curl

curl -sSL https://get.docker.com | sh

sudo usermod -aG docker $USER