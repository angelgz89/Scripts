#!/bin/bash

# Author: M4h0uT

sudo dmesg | grep VirtualBox > /dev/null 2>&1
    if [ "$(echo $?)" == "0" ];
    then
        echo -e "${yellowColour}[*]${endColour}${grayColour} Estamos en una maquina virtual...${endColour}"
        
        locate virtualbox-guest-x11  > /dev/null 2>&1

        if [ "$(echo $?)" == "0" ]
        then
        #Guest Additions Ubuntu
        echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando Guest Additions...${endColour}"
        sudo add-apt-repository -y multiverse  > /dev/null 2>&1
        sudo apt install -y virtualbox-guest-dkms virtualbox-guest-x11  > /dev/null 2>&1
        else 
        echo -e "${yellowColour}[*]${endColour}${grayColour} Guest Additions Instaladas...${endColour}"
        fi
    fi