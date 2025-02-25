#!/bin/bash

domain_name=$1
dirName="$domain_name-certificate"

# Create directory for certificate files
certPath="$HOME/Downloads/certificates-from-certbot/$dirName"
mkdir -p $certPath

# Install Certbot and Simply.com DNS Plugin (if not installed)
if ! command -v certbot &>/dev/null; then
    echo "Installing Certbot..."
    sudo apt update && sudo apt install -y certbot
fi

# Request both root and wildcard certificates
sudo certbot certonly --manual --preferred-challenges=dns -d "$domain_name" -d "*.$domain_name"

sleep 5

# Copy certificate and key
sudo cp /etc/letsencrypt/live/$domain_name/{fullchain.pem,privkey.pem} $certPath

sudo rm -rf /etc/letsencrypt/live/$domain_name
sudo rm -rf /etc/letsencrypt/archive/$domain_name
sudo rm -rf /etc/letsencrypt/renewal/$domain_name.conf

# Concatenate key and cert into a single PEM file
sudo cat $certPath/privkey.pem $certPath/fullchain.pem > $certPath/$domain_name.pem
# sudo rm -rf ./$dirName/privkey.pem ./$dirName/fullchain.pem