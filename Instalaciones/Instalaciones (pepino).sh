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

function maquinaVirtual()
{
	sudo dmesg | grep VirtualBox > /dev/null 2>&1
		if [ "$(echo $?)" == "0" ];
		then
			echo -e "${yellowColour}[*]${endColour}${grayColour} Estamos en una maquina virtual...${endColour}"

			sudo dpkg -l | grep -i virtualbox-guest-x11 > /dev/null 2>&1
			if [ "$(echo $?)" == "0" ]
			then
				echo -e "${yellowColour}[*]${endColour}${grayColour} Guest Additions Instaladas...${endColour}"
			else 
				#Guest Additions Ubuntu
				echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando Guest Additions...${endColour}"
				sudo add-apt-repository -y multiverse > /dev/null 2>&1
				sudo apt install -y virtualbox-guest-dkms virtualbox-guest-x11 > /dev/null 2>&1
			fi
		fi
}

function dependencies()
{
	tput civis #Ocultar la barra vertical de escribir
	clear

	############################################################################
	#Variable con los programas
	############################################################################
	dependencies=(sublime-text chromium-browser net-tools openssh-client docker zsh) 

	maquinaVirtual
	sleep 4

	echo -e "\n${yellowColour}[*]${endColour}${grayColour} Comprobando programas necesarios...${endColour}"
	sleep 3

	for program in "${dependencies[@]}" #recorre los programas en la variable dependencies
	do  

		echo -ne "${yellowColour}[*]${endColour}${blueColour} Herramienta${endColour}${purpleColour} $program${endColour}${blueColour}...${endColour}" #Este echo como es con -ne permite que se escriba cuando se acaba la linea no en otra

		#devuelve un 0 si el programa está instalado
		#Es igual que el which pero te devuelve un 0 si ok o un 1 si no existe

		#Ver si el programa esta instalado
		#locate $program > /dev/null 2>&1
		sudo dpkg -l | grep -i $program > /dev/null 2>&1

		if [ "$(echo $?)" == "0" ];
		then # Si el codigo que devuelve el ultimo proceso es 0 es que se ha ejecutado bien

			echo -e " ${greenColour}(V)${endColour}"

		else

			echo -e " ${redColour}(X)${endColour}\n"
			echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando herramienta ${endColour}${purpleColour}$program${endColour}${blueColour}...${endColour}\n"

			if [ "$program" == "sublime-text" ];
			then
				#SublimeText
				wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - > /dev/null 2>&1
				echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list > /dev/null 2>&1
				sudo apt update > /dev/null 2>&1
				sudo apt install -y sublime-text > /dev/null 2>&1
			fi

			if [ "$program" == "chromium-browser" ];
			then
				#Chronium
				sudo apt install -y chromium-browser > /dev/null 2>&1
				sudo apt-get remove firefox
				#deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
				#wget https://dl.google.com/linux/linux_signing_key.pub
				#sudo apt-key add linux_signing_key.pub
				#sudo apt update && sudo apt install google-chrome-stable
				#sudo apt install google-chrome-stable
			fi

			if [ "$program" == "net-tools" ];
			then
				#ifconfig
				sudo apt install -y net-tools > /dev/null 2>&1
			fi

			if [ "$program" == "openssh-client" ];
			then
				#Servidor SSH
				sudo apt install -y openssh-client > /dev/null 2>&1
			fi

			if [ "$program" == "docker" ];
			then
				# Docker
				sudo apt install -y docker.io > /dev/null 2>&1
				sudo apt install docker-ce
				sudo usermod -aG docker ${USER}

				# Docker-compose
				sudo pip install -y docker-compose > /dev/null 2>&1
			fi

			if [ "$program" == "zsh" ];
			then
				sudo apt-get install zsh -y
				sudo apt-get install git-core -y
				wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
				git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
				git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
				sudo apt install bat -y
				chsh -s `which zsh`


				#cambiar tema
				#nano ~/.zshrc
				#ZSH_THEME="bira"

				#plugins=(git
				#zsh-autosuggestions
				#zsh-syntax-highlighting
				#)
				#alias cat='bat'
			fi

		fi
		sleep 1
	done
}

# Main Function
dependencies
tput cnorm

#update
sudo apt-get update -y

sudo apt install tilix


#Visual Studio Code
#sudo apt install -y software-properties-common apt-transport-https wget
#wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
#sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
#sudo apt install -y code
#sudo apt update
sudo apt install snapd
sudo snap install --classic code

# Installing build essentials
sudo apt-get install -y build-essential libssl-dev -y


# TLP - saves battery when Ubuntu is installed on Laptops
sudo apt-get remove laptop-mode-tools -y
sudo add-apt-repository ppa:linrunner/tlp -y
sudo apt-get update -y
sudo apt-get install -y tlp tlp-rdw smartmontools ethtool -y
sudo tlp start

# KVM acceleration and cpu checker
sudo apt-get install -y cpu-checker
sudo apt-get install -y qemu-kvm libvirt-bin bridge-utils
sudo apt-get install -y lib32z1 lib32ncurses5 lib32bz2-1.0 lib32stdc++6

# Some random useful stuff
sudo apt-get install -y curl 
sudo apt-get install -y python-software-properties
sudo apt-get install -y python3
sudo apt-get install -y python-dev python-pip
sudo apt-get install -y libkrb5-dev

# Archive Extractors
sudo apt-get install -y unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller

#temas
sudo add-apt-repository universe -y
sudo apt install gnome-tweak-tool -y
apt search gnome-shell-extension
sudo apt-get install gtk2-engines-murrine gtk2-engines-pixbuf -y
sudo apt install arc-theme -y
sudo apt-get install unity-tweak-tool -y
sudo add-apt-repository ppa:papirus/papirus
sudo apt-get install papirus-icon-theme
sudo apt-get install papirus*

###################################################
#Seguridad


#Nmap
sudo apt install -y nmap


#aircrack
sudo apt install -y aircrack-ng

#Metasploit
sudo apt-get install -y postgresql
sudo apt install -y curl nmap sqlmap nikto
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall


###################################################
#Reiniciar
sudo reboot
