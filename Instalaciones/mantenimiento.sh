#!/bin/bash

# Author: M4h0uT

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

clear

if [ -e $1 ]
then
    echo "Por favor, Introduce la contraseña de sudo en el primer argumento"
    exit 1
else
    cont=$1
fi


########################################################################################################

function LimpiarHOME () 
{
    if [ -d $HOME/Descargas ];
    then
        touch $HOME/Descargas/hola.txt
    fi
    if [ -d $HOME/Downloads ];
    then
        touch $HOME/Downloads/hola.txt
    fi
    if [ -d $HOME/Escritorio ];
    then
        touch $HOME/Escritorio/hola.txt
    fi
    if [ -d $HOME/Desktop ];
    then
        touch $HOME/Desktop/hola.txt
    fi

    cd $HOME                      
    find -type d -empty -delete 2> /dev/null

    if [ -d $HOME/Descargas ];
    then
        rm $HOME/Descargas/hola.txt
    fi

    if [ -d $HOME/Downloads ];
    then
        rm $HOME/Downloads/hola.txt
    fi
    if [ -d $HOME/Escritorio ];
    then
        rm $HOME/Escritorio/hola.txt
    fi
    if [ -d $HOME/Desktop ];
    then
        rm $HOME/Desktop/hola.txt
    fi
}

function Backup () 
{
    if [ -d "/media/angel/baul" ];
    then
        echo -e "${purpleColour}Realizando Copia de seguridad en disco externo...${endColour}"
        rsync -ra --delete-before /home/angel/Descargas /media/angel/baul > /dev/null 2>&1
        rsync -ra --delete-before /home/angel/Scripts /media/angel/baul > /dev/null 2>&1
        rsync -ra --delete-before /home/angel/FondosPantalla /media/angel/baul > /dev/null 2>&1
        echo -e "${greenColour}Copia de seguridad terminada${endColour}"
    fi
}


# if [[ $EUID -ne 0 ]]; 
# then
#    echo "Tienes que ejecutar este script como sudo" 
#    exit 1
# else

########################################################################################################

# echo -e "${purpleColour}Por favor, introduce la contraseña de administrador : ${endColour}"
# read -s cont

########################################################################################################

echo -e "${turquoiseColour}Limpiando el sistema...${endColour}"
echo $cont | sudo -S apt update -y > /dev/null 2>&1

########################################################################################################

sudo dpkg --configure -a

########################################################################################################

echo -e "${purpleColour}Actualizando Paquetes...${endColour}"
sudo apt upgrade -y > /dev/null 2>&1

########################################################################################################
echo -e "${purpleColour}Actualizando Sistema...${endColour}"
sudo apt update -y > /dev/null 2>&1
sudo apt full-upgrade -y > /dev/null 2>&1

########################################################################################################

echo -e "${purpleColour}Realizando limpieza de instalaciones...${endColour}"
sudo apt autoremove -y > /dev/null 2>&1
sudo apt --fix-broken install -y > /dev/null 2>&1
sudo apt clean -y > /dev/null 2>&1
sudo apt autoclean -y > /dev/null 2>&1
sudo apt purge -y > /dev/null 2>&1

########################################################################################################

echo -e "${purpleColour}Limpiando carpetas vacias de $HOME...${endColour}"
LimpiarHOME

########################################################################################################

echo -e "${purpleColour}Borrando Ficheros temporales...${endColour}"
find . -type f -name "*.tmp" -exec rm -rf {} \;
find . -name "*.tmp" -exec rm -rf {} \;
find -type f -iname "*.tmp" -exec rm -f {} \;

########################################################################################################

echo -e "${purpleColour}Borrando Ficheros temporales2...${endColour}"
#sudo find /media/Backup/ -type f -name "*.*.*" -exec sudo rm -f {} \;

########################################################################################################

echo -e "${purpleColour}Borrando Ficheros MAC...${endColour}"
find . -type f -name ".DS_Store" -exec sudo rm -rf {} \;
find . -name ".DS_Store" -exec rm -rf {} \;

########################################################################################################

echo -e "${purpleColour}Limpiando Papelera...${endColour}"
sudo rm -rf /home/*/.local/share/Trash/*/**
sudo rm -rf /root/.local/share/Trash/*/**

########################################################################################################

echo -e "${purpleColour}Limpiando historial bash...${endColour}"
sudo echo "" > ~/.bash_history

########################################################################################################

Backup

########################################################################################################

echo -e "${purpleColour}Limpiando procesos innecesarios...${endColour}"
sudo killall chromedriver > /dev/null 2>&1
sudo killall chrome > /dev/null 2>&1

########################################################################################################

echo -e "${purpleColour}Limpiando Memoria RAM...${endColour}"
#sudo rm -f /var/log/*.old /var/log/*.gz /var/log/apt/* /var/log/auth* /var/log/daemon* /var/log/debug* /var/log/dmesg* /var/log/dpkg* /var/log/kern* /var/log/messages* /var/log/syslog* /var/log/user* /var/log/Xorg* /var/crash/*
sudo sync && sudo sysctl -w vm.drop_caches=3  > /dev/null 2>&1

########################################################################################################

echo -e "${purpleColour}Analizando rootkit...${endColour}"
sudo dpkg -l | grep -i "chkrootkit" > /dev/null 2>&1
if [ "$(echo $?)" == "1" ];
then
        sudo apt install chkrootkit -y
fi
sudo chkrootkit

########################################################################################################

#echo -e "${purpleColour}Antivirus...${endColour}"
#sudo dpkg -l | grep -i "clamav" > /dev/null 2>&1
#if [ "$(echo $?)" == "1" ];
#then
#        sudo apt install clamav -y
#fi

########################################################################################################
echo ""
echo -e "${greenColour}PROCESO DE MANTENIMIENTO COMPLETADO${endColour}"
echo ""

#fi
