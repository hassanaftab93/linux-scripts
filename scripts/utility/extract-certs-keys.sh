#/#!/bin/bash

# Pass in filename for certificate and textfile for password e.g
# ./extract-certs-keys.sh certificate.pfx password.txt

# Assign values to variables
certificate_file="$1"
password_file="$2"
password=$(cat "$password_file")

# Generate certificate
openssl pkcs12 -in "$certificate_file" -passin pass:"$password" -passout pass:"$password" -nokeys | sed -n '/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/p' > my-cert.crt

# Generate private key
openssl pkcs12 -in "$certificate_file" -nocerts -passin pass:"$password" -passout pass:"$password" | openssl rsa -passin pass:"$password" -passout pass:"$password" -out my-key.key

mkdir -p outputs
mv my-cert.crt outputs/
mv my-key.key outputs/