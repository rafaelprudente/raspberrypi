#!/bin/bash

clear

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

export DEBIAN_FRONTEND=noninteractive

echo -e "${CYAN}---------- ADD REPOSITORIES ----------${NC}"
if $(grep -q webmin /etc/apt/sources.list); then 
	echo -e "${GREEN}webmin is in sources file${NC}"; 
else 
	echo -e "${RED}webmin is not in sources file${NC}"; 
	echo "" | sudo tee -a /etc/apt/sources.list > /dev/null; 
	echo "deb https://download.webmin.com/download/repository sarge contrib" | sudo tee -a /etc/apt/sources.list > /dev/null; 

	echo -e "${RED}delete old key${NC}"; 
	sudo rm -f /root/jcameron-key.asc

	echo -e "${RED}download new key${NC}"; 
	sudo wget http://www.webmin.com/jcameron-key.asc -P /root

	echo -e "${RED}install key${NC}"; 
	sudo apt-key add /root/jcameron-key.asc
fi

echo -e "${CYAN}---------- FIRST UPDATE ----------${NC}"
sudo apt -yq update

echo -e "${CYAN}---------- FIRST UPGRADE ----------${NC}"
sudo apt -yq full-upgrade

echo -e "${CYAN}---------- WHIPTAIL ----------${NC}"
sudo apt -yq install whiptail 

echo -e "${CYAN}---------- GIT ----------${NC}"
sudo apt -yq install git 

echo -e "${CYAN}---------- NMAP ----------${NC}"
sudo apt -yq install nmap

echo -e "${CYAN}---------- WEBMIN ----------${NC}"
sudo apt -yq install apt-transport-https
sudo apt -yq install webmin

echo -e "${CYAN}---------- INSTALL JAVA 8 ----------${NC}"
sudo apt -yq install openjdk-8-jre 

echo -e "${CYAN}---------- INSTALL JAVA 11 ----------${NC}"
sudo apt -yq install openjdk-11-jre 

echo -e "${CYAN}---------- FIND GATEWAY ----------${NC}"
gateway=$(route -n | grep UG | grep -E -o "(1[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)")
echo "Gateway: $gateway"

echo -e "${CYAN}---------- FIND NEW IP ----------${NC}"

IFS='.'
read -ra ipAddr <<< "$gateway"
IFS=' '
rootIP="${ipAddr[0]}.${ipAddr[1]}.${ipAddr[2]}"
echo "Root IP: $rootIP"
 
sudo nmap -sP -oG - $rootIP.0/24 | grep -E -o "(1[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" > ips.txt
lastIP=0
while read IP; do
   IFS='.'
   read -ra ipAddr <<< "$IP"
   IFS=' '
   if test ${ipAddr[3]} -ge $lastIP; then
      lastIP=${ipAddr[3]}; 
   fi
done < ips.txt
rm -f ips.txt
lastIP=$(( $lastIP + 1 ))
newIP="$rootIP.$lastIP"
echo "Available IP: $newIP"

echo -e "${CYAN}---------- SSH ----------${NC}"
sudo systemctl enable ssh
sudo systemctl start ssh

read -p "Reboot now [Y/N]? " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo
    echo -e "${GREEN}Done!${NC}"
    exit 0
fi
sudo reboot
