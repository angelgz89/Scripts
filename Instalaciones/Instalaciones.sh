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

export DEBIAN_FRONTEND=noninteractive #Para que no salga el menu de instalación grafico

clear

echo -e "${turquoiseColour} Actualizando el sistema...${endColour}"
sudo apt update -y > /dev/null 2>&1
sudo apt upgrade -y > /dev/null 2>&1
sudo apt update -y > /dev/null 2>&1
sudo apt unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades
clear
echo -e "${turquoiseColour} Comienza la comprobacion...${endColour}"
sleep 5
clear

########################################################################################################

sudo dmesg | grep VirtualBox > /dev/null 2>&1
	if [ "$(echo $?)" == "0" ];
	then
		echo -e "${turquoiseColour} Estamos en una maquina virtual ${endColour}"
		
		sudo dpkg -l | grep -i "virtualbox-guest-x11" > /dev/null 2>&1

		if [ "$(echo $?)" == "1" ]
		then
			echo -e "${yellowColour}[*]${endColour}${greenColour} Instalando Guest Additions...${endColour}"
			sudo add-apt-repository -y multiverse > /dev/null 2>&1
			sudo apt install -y virtualbox-guest-dkms virtualbox-guest-x11 > /dev/null 2>&1
			echo -e "${greenColour} Instalado ${endColour}"
		else 
			echo -e "${blueColour} Guest Additions ${endColour}${greenColour}Instaladas${endColour}${endColour}"
		fi
	else 
		echo -e "${turquoiseColour} No estamos en una maquina virtual ${endColour}"
	fi

sleep 1
########################################################################################################

sudo dpkg -l | grep -i "Code editing" > /dev/null 2>&1

if [ "$(echo $?)" == "1" ];
then
	echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando Visual Studio Code...${endColour}"
	#Visual Studio Code
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - > /dev/null 2>&1
	sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /dev/null 2>&1
	sudo apt install -y code > /dev/null 2>&1
	sudo apt update -y > /dev/null 2>&1
	echo -e "${greenColour} Instalado ${endColour}"
else
	echo -e "${blueColour} Visual Studio Code ${endColour}${greenColour}Instalado${endColour}${endColour}"
fi

sleep 1
########################################################################################################

sudo dpkg -l | grep -i "zsh" > /dev/null 2>&1
if [ "$(echo $?)" == "1" ];
then
	echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando ZSH...${endColour}"
	sudo apt-get install -y zsh > /dev/null 2>&1
	sudo apt-get install -y git > /dev/null 2>&1
	wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions > /dev/null 2>&1
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting > /dev/null 2>&1
	sudo apt install -y bat > /dev/null 2>&1
	chsh -s `which zsh` > /dev/null 2>&1
	cp zshrc ~/.zshrc
	echo -e "${greenColour} Instalado ${endColour}"
else
	echo -e "${blueColour} ZSH ${endColour}${greenColour}Instalado${endColour}${endColour}"
fi

sleep 1
########################################################################################################

sudo dpkg -l | grep -i "net-tools" > /dev/null 2>&1
if [ "$(echo $?)" == "1" ];
then
	echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando net-tools...${endColour}"
	sudo apt install -y net-tools > /dev/null 2>&1
	echo -e "${greenColour} Instalado ${endColour}"
else
	echo -e "${blueColour} Net-tools ${endColour}${greenColour}Instalado${endColour}${endColour}"
fi

########################################################################################################

sudo dpkg -l | grep -i "openssh-client" > /dev/null 2>&1
if [ "$(echo $?)" == "1" ];
then
	echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando openssh-client...${endColour}"
	sudo apt install -y openssh-client > /dev/null 2>&1
	echo -e "${greenColour} Instalado ${endColour}"
else
	echo -e "${blueColour} Openssh-client ${endColour}${greenColour}Instalado${endColour}${endColour}"
fi

sleep 1
########################################################################################################

sudo dpkg -l | grep -i "docker" > /dev/null 2>&1
if [ "$(echo $?)" == "1" ];
then
	echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando Docker...${endColour}"
	sudo apt install -y curl > /dev/null 2>&1
	sudo apt-get update -y > /dev/null 2>&1
	sudo apt-get install \ apt-transport-https \ ca-certificates \ curl \ gnupg \ lsb-release  -y > /dev/null 2>&1
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg  -y > /dev/null 2>&1
	echo \ "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \ $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update > /dev/null 2>&1
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io > /dev/null 2>&1

	sudo usermod -aG docker ${USER} > /dev/null 2>&1

	# Docker-compose
	sudo pip install -y docker-compose > /dev/null 2>&1
	echo -e "${greenColour} Instalado ${endColour}"
else
	echo -e "${blueColour} Docker ${endColour}${greenColour}Instalado${endColour}${endColour}"
fi

sleep 1
########################################################################################################

sudo dpkg -l | grep -i "chrome" > /dev/null 2>&1
if [ "$(echo $?)" == "1" ];
then
	echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando Chrome...${endColour}"
	deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main > /dev/null 2>&1
	wget https://dl.google.com/linux/linux_signing_key.pub > /dev/null 2>&1
	sudo apt-key add linux_signing_key.pub > /dev/null 2>&1
	sudo apt update > /dev/null 2>&1
	sudo apt install -y google-chrome-stable > /dev/null 2>&1
	echo -e "${greenColour} Instalado ${endColour}"
else
	echo -e "${blueColour} Chrome ${endColour}${greenColour}Instalado${endColour}${endColour}"
fi

sleep 1
########################################################################################################

sudo dpkg -l | grep -i "tilix" > /dev/null 2>&1
if [ "$(echo $?)" == "1" ];
then
	echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando Tilix...${endColour}"
	sudo apt install -y tilix > /dev/null 2>&1
	echo -e "${greenColour} Instalado ${endColour}"
else
	echo -e "${blueColour} Tilix ${endColour}${greenColour}Instalado${endColour}${endColour}"
fi

sleep 1
########################################################################################################

sudo dpkg -l | grep -i "nmap" > /dev/null 2>&1
if [ "$(echo $?)" == "1" ];
then
	echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando Nmap...${endColour}"
	sudo apt install -y nmap -y > /dev/null 2>&1
	echo -e "${greenColour} Instalado ${endColour}"
else
	echo -e "${blueColour} Nmap ${endColour}${greenColour}Instalado${endColour}${endColour}"
fi

sleep 1
########################################################################################################

sudo dpkg -l | grep -i "synaptic" > /dev/null 2>&1
if [ "$(echo $?)" == "1" ];
then
	echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando synaptic...${endColour}"
	sudo apt install -y synaptic > /dev/null 2>&1
	echo -e "${greenColour} Instalado ${endColour}"
else
	echo -e "${blueColour} Synaptic ${endColour}${greenColour}Instalado${endColour}${endColour}"
fi

sleep 1
########################################################################################################

sudo dpkg -l | grep -i "gnome-tweak-tool" > /dev/null 2>&1
if [ "$(echo $?)" == "1" ];
then
	echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando Gnome-tweak-tool...${endColour}"
	sudo add-apt-repository universe -y > /dev/null 2>&1
	sudo apt-get install gnome-tweak-tool -y > /dev/null 2>&1
	sudo add-apt-repository ppa:papirus/papirus > /dev/null 2>&1
	sudo apt install papirus-icon-theme -y > /dev/null 2>&1
	sudo apt install gnome-shell-extensions chrome-gnome-shell -y > /dev/null 2>&1
	mkdir .themes
	mkdir .icons
	git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git > /dev/null 2>&1
	cd WhiteSur-gtk-theme/ > /dev/null 2>&1
	chmod 777 ./install.sh > /dev/null 2>&1
	./install.sh -c dark -c light > /dev/null 2>&1
	./install.sh -i simple > /dev/null 2>&1
	sudo ./tweaks.sh -g -D > /dev/null 2>&1
	firefox https://extensions.gnome.org/
	cd ~/

	echo -e "${greenColour} Instalado ${endColour}"
else
	echo -e "${blueColour} Gnome-tweak-tool ${endColour}${greenColour}Instalado${endColour}${endColour}"
fi
sleep 1

sudo apt update -y > /dev/null 2>&1
sudo apt upgrade -y > /dev/null 2>&1
sudo apt update -y > /dev/null 2>&1
echo -e "${yellowColour} Proceso terminado ${endColour}"

