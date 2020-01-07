#!/bin/bash

clear

CYAN='\033[0;36m'
NC='\033[0m'

export DEBIAN_FRONTEND=noninteractive

#echo 10 | whiptail --title "Initial Setup" --gauge "Perform Update" 8 78 0
#echo -e "${CYAN}---------- FIRST UPDATE ----------${NC}"
sudo apt -yq update | debconf-apt-progress

#echo 20 | whiptail --title "Initial Setup" --gauge "Perform Upgrade" 8 78 0
echo -e "${CYAN}---------- FIRST UPGRADE ----------${NC}"
sudo apt -yq full-upgrade | debconf-apt-progress

#echo 30 | whiptail --title "Initial Setup" --gauge "Perform WHIPTAIL Install" 8 78 0
echo -e "${CYAN}---------- WHIPTAIL ----------${NC}"
sudo apt -yq install whiptail >> rasp-init-setup.log

echo 40 | whiptail --title "Initial Setup" --gauge "Perform GIT Install" 8 78 0
#echo -e "${CYAN}---------- GIT ----------${NC}"
sudo apt -yq install git >> rasp-init-setup.log

echo 40 | whiptail --title "Initial Setup" --gauge "Perform ARP-SCAN Install" 8 78 0
#echo -e "${CYAN}---------- ARP-SCAN ----------${NC}"
sudo apt -yq install arp-scan >> rasp-init-setup.log

echo 50 | whiptail --title "Initial Setup" --gauge "Perform JAVA 8 Install" 8 78 0
#echo -e "${CYAN}---------- INSTALL JAVA 8 ----------${NC}"
sudo apt -yq install openjdk-8-jre >> rasp-init-setup.log

echo 60 | whiptail --title "Initial Setup" --gauge "Perform JAVA 11 Install" 8 78 0
#echo -e "${CYAN}---------- INSTALL JAVA 11 ----------${NC}"
sudo apt -yq install openjdk-11-jre >> rasp-init-setup.log

