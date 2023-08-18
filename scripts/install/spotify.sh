#!/bin/bash

# Update apt and install dependencies
sudo apt update
sudo apt install curl -y

# Install gpg key
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg

# Add Spotify Repo
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

# Install Spotify
sudo apt update
sudo apt install spotify-client -y