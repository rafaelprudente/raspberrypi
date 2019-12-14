#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

#clear

echo
echo ---------- FIRST UPDATE/UPGRADE ----------
echo 
#sudo DEBIAN_FRONTEND=noninteractive apt -yq update
#sudo DEBIAN_FRONTEND=noninteractive apt -yq full-upgrade

echo
echo ---------- GATEWAY ----------
gateway=$(route -n | grep UG | grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)")
echo $gateway

echo
echo ---------- GIT ----------
echo 
#sudo DEBIAN_FRONTEND=noninteractive apt -yq install git

echo
echo ---------- SSH ----------
echo 
#sudo systemctl enable ssh
#sudo systemctl start ssh

echo
echo -e "${GREEN}Done!${NC}"
