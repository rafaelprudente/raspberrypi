#!/bin/bash

clear

echo ########## FIRST UPDATE/UPGRADE ##########
echo 
sudo DEBIAN_FRONTEND=noninteractive apt -yq update
sudo DEBIAN_FRONTEND=noninteractive apt -yq full-upgrade

echo ########## GIT ##########
echo 
sudo DEBIAN_FRONTEND=noninteractive apt -yq install git
