#!/bin/bash

clear

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

