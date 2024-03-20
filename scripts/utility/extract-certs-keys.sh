#!/bin/bash

# Pass in filename for certificate and textfile for password e.g

# ./extract-certs-keys.sh path_to_certificate.pfx path_to_password_file.txt

# Assign values to variables
certificate_file="$1"
password_file="$2"
password=$(cat "$password_file")

cert_dir=$(dirname "${certificate_file}")
outputs_folder="${cert_dir}/outputs"
mkdir -p "$outputs_folder"

# Generate certificate
openssl pkcs12 -in "$certificate_file" -passin pass:"$password" -passout pass:"$password" -nokeys | sed -n '/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/p' > "$outputs_folder/my-cert.crt"

# Generate private key
openssl pkcs12 -in "$certificate_file" -nocerts -passin pass:"$password" -passout pass:"$password" | openssl rsa -passin pass:"$password" -passout pass:"$password" -out "$outputs_folder/my-key.key"