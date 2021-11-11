#! /bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: M4h0uT

#Colours
verde="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
rojo="\e[0;31m\033[1m"
turquesa="\e[0;34m\033[1m"
amarillo="\e[0;33m\033[1m"
lila="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
gris="\e[0;37m\033[1m"



function login ()
{
    clear
    echo -e "${lila}Por favor, introduce la contraseña de administrador: ${endColour}"
    read -s cont
    clear
}

#########################

login