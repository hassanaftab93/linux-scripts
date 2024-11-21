#!/bin/bash

domain_name=$1

# Generate certificate signing request
openssl req -new -newkey rsa:2048 -nodes -keyout $domain_name.key -out $domain_name.csr

# Generate self-signed certificate
sudo certbot certonly --manual --preferred-challenges=dns -d $domain_name

sleep 5

# Copy cert and key
sudo cp /etc/letsencrypt/live/$domain_name/{fullchain.pem,privkey.pem} .