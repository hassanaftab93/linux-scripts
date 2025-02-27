#!/bin/bash

# Example use: ./get-certificate-for.sh example.com

# Variables
domain_name=$1

if [[ -z "$domain_name" ]]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

# Set Date Values
current_date=$(date +"%Y-%m-%d")
expiration_date=$(date -d "$current_date +3 months" +"%d-%m-%Y")

# Set Sanitized Domain Name
sanitized_domain_name=$(echo "$domain_name" | tr '.' '-')

# Set Certificate Variables
dirName="$domain_name-certificate"
certPath="$HOME/Downloads/certificates-from-certbot/$dirName"

# Azure Key Vault Variables
# Make sure you azure cli is logged in and you have the necessary permissions to access the key vault
resourceGroupName="teo-global-rg"
keyVaultName="teo-global-kv"
certificatePassword=""

# Script
echo "Requesting certificate for $domain_name..."

# Ensure the directory exists
mkdir -p "$certPath"
upload_status_file="$certPath/upload_status_$(date -d "$current_date" +"%d-%m-%Y").txt"

# Install Certbot and Simply.com DNS Plugin (if not installed)
if ! command -v certbot &>/dev/null; then
    echo "Installing Certbot..."
    sudo apt update && sudo apt install -y certbot
fi

# Request both root and wildcard certificates
sudo certbot certonly --manual --preferred-challenges=dns -d "$domain_name" -d "*.$domain_name"

sleep 5

# Check if Certbot successfully created the certificate
if ! sudo test -f "/etc/letsencrypt/live/$domain_name/fullchain.pem" || ! sudo test -f "/etc/letsencrypt/live/$domain_name/privkey.pem"; then
    echo "Error: Certificate generation failed for $domain_name"
    exit 1
fi

# Copy certificate and key
sudo cp /etc/letsencrypt/live/$domain_name/{fullchain.pem,privkey.pem} "$certPath"

# Cleanup old Certbot files
sudo rm -rf /etc/letsencrypt/live/$domain_name
sudo rm -rf /etc/letsencrypt/archive/$domain_name
sudo rm -rf /etc/letsencrypt/renewal/$domain_name.conf

# Concatenate key and cert into a single PEM file
sudo cat "$certPath/privkey.pem" "$certPath/fullchain.pem" > "$certPath/$domain_name.pem"

echo "Certificate files are saved in $certPath"

# Prompt the user for uploading to Azure Key Vault
read -p "Do you want to upload the certificate to Azure Key Vault? (y/n): " upload_choice
if [[ "$upload_choice" =~ ^[Yy]$ ]]; then
    az keyvault certificate import --name "star-$sanitized_domain_name" --password "$certificatePassword" --vault-name "$keyVaultName" --file "$certPath/$domain_name.pem"
    echo "Certificate star-$sanitized_domain_name uploaded to Azure Key Vault: $keyVaultName"

    # Append to file upload_status.txt
    echo -e "\n--------------------BEGIN--------------------\n" >> "$upload_status_file"

    echo -e "---------------------------------------------\n" >> "$upload_status_file"
    echo -e "Certificate Upload Status\n" >> "$upload_status_file"
    echo -e "Certificate: star-$sanitized_domain_name\n" >> "$upload_status_file"
    echo -e "----------------------------------------\n" >> "$upload_status_file"

    echo -e "✅ Certificate uploaded successfully!\n" >> "$upload_status_file"

    echo -e "📅 Upload Date      : $(date -d "$current_date" +"%d-%m-%Y")\n >> "$upload_status_file"
    echo -e "⏳ Expiration Date  : $expiration_date\n" >> "$upload_status_file"

    echo -e "🔹 Resource Group   : $resourceGroupName\n" >> "$upload_status_file"
    echo -e "🔹 Azure Key Vault  : $keyVaultName\n" >> "$upload_status_file"
    echo -e "---------------------------------------------\n" >> "$upload_status_file"

    echo -e "\n---------------------END---------------------\n" >> "$upload_status_file"
else
    echo -e "\nCertificate upload skipped."
fi