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
gateway=$(route -n | grep UG | grep -E -o "(1[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)")
echo $gateway
sudo cp /etc/dhcpcd.conf /etc/dhcpcd.conf.bkp
echo "hostname" > /etc/dhcpcd.conf
echo "clientid" >> /etc/dhcpcd.conf
echo "persistent" >> /etc/dhcpcd.conf
echo "option rapid_commit" >> /etc/dhcpcd.conf
echo "option domain_name_servers, domain_name, domain_search, host_name" >> /etc/dhcpcd.conf
echo "option classless_static_routes" >> /etc/dhcpcd.conf
echo "option interface_mtu" >> /etc/dhcpcd.conf
echo "require dhcp_server_identifier" >> /etc/dhcpcd.conf
echo "slaac private" >> /etc/dhcpcd.conf
echo "static ip_address=192.168.1.201/24" >> /etc/dhcpcd.conf
echo "static routers=$gateway" >> /etc/dhcpcd.conf
echo "static domain_name_servers=$gateway" >> /etc/dhcpcd.conf

sudo cat /etc/dhcpcd.conf
sudo cp /etc/dhcpcd.conf.bkp /etc/dhcpcd.conf

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
