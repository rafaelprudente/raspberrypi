#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

clear

echo ---------- FIRST UPDATE/UPGRADE ----------
echo 
sudo DEBIAN_FRONTEND=noninteractive apt -yq update
sudo DEBIAN_FRONTEND=noninteractive apt -yq full-upgrade

echo ---------- GIT ----------
echo 
sudo DEBIAN_FRONTEND=noninteractive apt -yq install git

echo
echo -e "${GREEN}DONE!${NC}"
