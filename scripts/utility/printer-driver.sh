#!/bin/bash

sudo apt update

sudo apt install -y cups cups-client cups-filters cups-ipp-utils

sudo /usr/sbin/adduser root lpadmin
sudo groups root
sudo service cups start
sudo service cups restart

# Only enable once, running script 1st time
sudo systemctl enable cups
sudo systemctl start cups
sudo systemctl status cups

# CUPS is hosted on http://127.0.0.1:631