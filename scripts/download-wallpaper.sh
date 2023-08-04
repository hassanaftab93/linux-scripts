#!/bin/bash

# This script assumes there is a directory ~/Pictures/Wallpapers

# Passing link to the wget function

cd ~/Pictures/Wallpapers

echo -e "\nLink pasted: $1"
echo -e "\nDownloading.."

wget $1

echo -e "\nDownloaded!"
open .