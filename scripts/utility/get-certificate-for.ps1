# Example use: .\get-certificate-for.ps1 -DomainName example.com

param(
    [Parameter(Mandatory)]
    [string]$DomainName
)

# Strip leading wildcard if the user passed *.example.com instead of example.com
if ($DomainName -match '^\*\.(.+)$') { $DomainName = $Matches[1] }

# Set Date Values
$currentDate      = Get-Date
$expirationDate   = $currentDate.AddMonths(3).ToString("dd-MM-yyyy")

# Set Sanitized Domain Name
$sanitizedDomainName = $DomainName -replace '\.', '-'

# Set Certificate Variables
$dirName  = "$DomainName-certificate"
$certPath = "$env:USERPROFILE\Downloads\certificates-from-certbot\$dirName"

# Azure Key Vault Variables
# Make sure az cli is logged in and you have the necessary permissions
$resourceGroupName   = "teo-global-rg"
$keyVaultName        = "teo-global-kv"
$certificatePassword = ""

Write-Host "Requesting certificate for $DomainName..."

# Ensure the output directory exists
New-Item -ItemType Directory -Force -Path $certPath | Out-Null
$uploadStatusFile = "$certPath\upload_status_$($currentDate.ToString('dd-MM-yyyy')).txt"

# Temp directory mounted into the certbot container as /etc/letsencrypt
$leTempPath = "$certPath\letsencrypt-tmp"
New-Item -ItemType Directory -Force -Path $leTempPath | Out-Null

# Run certbot via Docker — no local install needed.
# -it is required so certbot can pause and prompt you to add the DNS TXT record.
# After certbot prints the _acme-challenge TXT value, add it to your DNS, wait
# for propagation, then press Enter in this terminal to continue.
docker run --rm -it `
    -v "${leTempPath}:/etc/letsencrypt" `
    certbot/certbot certonly `
    --manual `
    --preferred-challenges=dns `
    -d "*.$DomainName"

if ($LASTEXITCODE -ne 0) {
    Write-Error "Certbot failed — certificate not obtained for $DomainName."
    exit 1
}

# Certbot symlinks in live/ don't resolve reliably on Windows volumes.
# Read from archive/ where the actual files are written.
$archivePath   = "$leTempPath\archive\$DomainName"
$fullchainFile = Get-ChildItem "$archivePath\fullchain*.pem" -ErrorAction SilentlyContinue |
                    Sort-Object Name | Select-Object -Last 1
$privkeyFile   = Get-ChildItem "$archivePath\privkey*.pem"   -ErrorAction SilentlyContinue |
                    Sort-Object Name | Select-Object -Last 1

if (-not $fullchainFile -or -not $privkeyFile) {
    Write-Error "Certificate files not found in $archivePath after certbot run."
    exit 1
}

# Copy certificate and key to the output directory
$fullchainDest = "$certPath\fullchain.pem"
$privkeyDest   = "$certPath\privkey.pem"
Copy-Item $fullchainFile.FullName $fullchainDest -Force
Copy-Item $privkeyFile.FullName  $privkeyDest   -Force

# Cleanup certbot temp directory
Remove-Item -Recurse -Force $leTempPath

# Concatenate key + cert into a single PEM (privkey first, matches original script)
$combinedPem = "$certPath\$DomainName.pem"
$privkeyContent   = Get-Content $privkeyDest   -Raw
$fullchainContent = Get-Content $fullchainDest -Raw
Set-Content -Path $combinedPem -Value ($privkeyContent + $fullchainContent) -NoNewline

Write-Host "Certificate files are saved in $certPath"

# Prompt the user for uploading to Azure Key Vault
$uploadChoice = Read-Host "`nDo you want to upload the certificate to Azure Key Vault? (y/n)"
if ($uploadChoice -match '^[Yy]$') {
    az keyvault certificate import `
        --name     "star-$sanitizedDomainName" `
        --password $certificatePassword `
        --vault-name $keyVaultName `
        --file     $combinedPem

    Write-Host "Certificate star-$sanitizedDomainName uploaded to Azure Key Vault: $keyVaultName"

    $uploadDate = $currentDate.ToString("dd-MM-yyyy")
    Add-Content -Path $uploadStatusFile -Value @"

--------------------BEGIN--------------------

---------------------------------------------

Certificate Upload Status

Certificate: star-$sanitizedDomainName

----------------------------------------

Certificate uploaded successfully!

Upload Date      : $uploadDate

Expiration Date  : $expirationDate

Resource Group   : $resourceGroupName

Azure Key Vault  : $keyVaultName

---------------------------------------------

---------------------END---------------------

"@
} else {
    Write-Host "`nCertificate upload skipped."
}
