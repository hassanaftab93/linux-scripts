#!/bin/bash

# Update apt and install dependencies
sudo apt update

sudo docker pull portainer/portainer-ce:linux-arm64
sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:linux-arm64