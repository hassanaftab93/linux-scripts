#!/bin/bash

# Update apt and install dependencies
sudo apt update

# Install nodejs
sudo apt install -y Node.js
sudo apt install -y npm

# Verify Installation
Node.js -v && npm --version