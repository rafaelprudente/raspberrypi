#!/bin/bash

clear

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

export DEBIAN_FRONTEND=noninteractive

echo -e "${CYAN}---------- FIRST UPDATE ----------${NC}"
sudo apt -yq update

echo -e "${CYAN}---------- FIRST UPGRADE ----------${NC}"
sudo apt -yq full-upgrade

echo -e "${CYAN}---------- WHIPTAIL ----------${NC}"
sudo apt -yq install whiptail 

echo -e "${CYAN}---------- GIT ----------${NC}"
sudo apt -yq install git 

echo -e "${CYAN}---------- ARP-SCAN ----------${NC}"
sudo apt -yq install arp-scan 

echo -e "${CYAN}---------- INSTALL JAVA 8 ----------${NC}"
sudo apt -yq install openjdk-8-jre 

echo -e "${CYAN}---------- INSTALL JAVA 11 ----------${NC}"
sudo apt -yq install openjdk-11-jre 

echo
echo -e "${CYAN}---------- FIND GATEWAY ----------${NC}"
echo 
gateway=$(route -n | grep UG | grep -E -o "(1[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)")
echo "Gateway: $gateway"

echo
echo -e "${CYAN}---------- FIND NEW IP ----------${NC}"
echo

IFS='.'
read -ra ipAddr <<< "$gateway"
IFS=' '
rootIP="${ipAddr[0]}.${ipAddr[1]}.${ipAddr[2]}"
 
sudo arp-scan -I eth0 $rootIP.0/24 | grep -E -o "(1[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" > ips.txt
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

#clear
