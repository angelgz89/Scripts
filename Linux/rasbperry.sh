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

echo "Por favor, introduce la contraseña de administrador para usar el programa:"
read -s cont

function actualizarlimpiar()
{
	sudo apt update -y
	sudo apt full-upgrade -y
	sudo apt dist-upgrade -y
	sudo apt update -y
	sudo apt autoremove -y
	sudo apt --fix-broken install
}

function ZSH ()
{

	sudo apt install -y zsh
	wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
	sudo git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions > /dev/null 2>&1
	sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting > /dev/null 2>&1
	echo ' ' > .zshrc
	echo '
	export ZSH=$HOME/.oh-my-zsh

	ZSH_THEME="bira"

	plugins=(git
	zsh-autosuggestions
	zsh-syntax-highlighting
	)
	source $ZSH/oh-my-zsh.sh
	
	export PATH="$PATH:$HOME/Scripts/Linux"' > .zshrc

	echo $cont | chsh -s `which zsh`
}

function PIP ()
{
	sudo pip3 install gspread
	sudo pip3 install selenium
	sudo pip3 install oauth2client
	sudo pip3 intall python-dateutil
	sudo pip3 install paho-mqtt
}

function SSH () 
{
	sudo apt install -y openssh-client openssh-server openssh-sftp-server -y
	sudo apt install sshpass -y
	sudo touch ~/.hushlogin
}

function Basicos () 
{
	echo " "
	echo "Instalando Programas..."

	sudo apt install git -y
	sudo apt install neofetch -y
	sudo apt install samba -y
	sudo apt install wget -y
    sudo apt install cockpit
    echo $cont | sudo -S systemctl restart cockpit

    sudo apt-get install build-essential gcc make perl dkms -y
    sudo apt install software-properties-common apt-transport-https -y
    sudo apt install rsync -y 
    
    sudo apt-get install lm-sensors -y 

	sudo dpkg -l | grep -i "binutils" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
		sudo apt install binutils -y > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde} Binutils Instalado${endColour}"
	fi

	sudo dpkg -l | grep -i "python3-pip" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
		sudo apt install python3 python3-pip -y > /dev/null 2>&1
        PIP
		echo -e "${amarillo}[*]${endColour}${verde} Python3 Instalado${endColour}"
	fi

	sudo dpkg -l | grep -i "mosquitto" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
		sudo apt install mosquitto mosquitto-clients -y > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde} Mosquitto Instalado${endColour}"
	fi

	sudo dpkg -l | grep -i "htop" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
		sudo apt install htop -y > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde} Htop Instalado${endColour}"
	fi

	sudo dpkg -l | grep -i "wakeonlan" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
		sudo apt install wakeonlan -y > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde} WakeOnLan Instalado${endColour}"
	fi

	sudo dpkg -l | grep -i "chromium-chromedriver" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
		sudo apt install chromium-driver -y > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde} Chronium-driver Instalado${endColour}"
	fi

	sudo dpkg -l | grep -i "net-tools" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
		sudo apt install net-tools -y > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde} Net-tools Instalado${endColour}"
	fi

	ZSH
    PIP
	actualizarlimpiar
    SSH
}

######################################
actualizarlimpiar
Basicos
actualizarlimpiar
sudo apt dist-upgrade -y 
sudo rpi-update -y

echo -e "${turquesa}Instalar No-Ip Agent?: (s / n)${endColour}"
read confirmacion

if [ $confirmacion == "s" ];
then
    cd /usr/local/src
    sudo wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
    sudo tar xzf noip-duc-linux.tar.gz
    cd noip-2.1.9-1
    sudo make
    sudo make install
    # sudo /usr/local/bin/noip2 -C
    echo -e "${amarillo}[*]${endColour}${verde} No-Ip Agent Instalado ${endColour}"

    # systemctl enable noip2.service (start on boot)
    # systemctl start noip2.service (start immediately)
    # systemctl status noip2.service (for status)
fi

actualizarlimpiar

git config --global user.name angelgz89
git config --global user.email agz2712@gmail.com