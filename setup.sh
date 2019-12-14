#!/bin/bash

clear

echo ########## FIRST UPDATE/UPGRADE ##########
echo 
sudo apt update -y
sudo apt full-upgrade

echo ########## GIT ##########
echo 
sudo apt install git
