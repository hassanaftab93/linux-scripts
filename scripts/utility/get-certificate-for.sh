#!/bin/bash

domain_name=$1
dirName="$domain_name-certificate"

mkdir -p $dirName/miscFiles

# # Generate certificate signing request (not needed for Certbot, but keeping for reference)
# openssl req -new -newkey rsa:2048 -nodes -keyout ./$dirName/miscFiles/$domain_name.key -out ./$dirName/miscFiles/$domain_name.csr

# Request both root and wildcard certificates
sudo certbot certonly --manual --preferred-challenges=dns -d "$domain_name" -d "*.$domain_name"

sleep 5

# Copy certificate and key
sudo cp /etc/letsencrypt/live/$domain_name/{fullchain.pem,privkey.pem} ./$dirName

# Concatenate key and cert into a single PEM file
sudo cat ./$dirName/privkey.pem ./$dirName/fullchain.pem > ./$dirName/$domain_name.pem
sudo rm -rf ./$dirName/privkey.pem ./$dirName/fullchain.pem