#! /bin/bash
# -*- ENCODING: UTF-8 -*-

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

########################################################################################################

echo -e "${blueColour}Contraseña de sudo: ${endColour}"
read -s cont

echo -e "${turquoiseColour}Actualizando el sistema...${endColour}"
echo $cont | sudo -S apt update -y > /dev/null 2>&1
sudo apt upgrade -y > /dev/null 2>&1
sudo apt update -y > /dev/null 2>&1
sudo apt full-upgrade -y > /dev/null 2>&1
sudo apt-get install wget -y > /dev/null 2>&1
# sudo apt unattended-upgrades
# sudo dpkg-reconfigure --priority=low unattended-upgrades

clear

echo "${turquoiseColour}Comienza la comprobacion...${endColour}"

clear

########################################################################################################

echo -e "${turquoiseColour}Acabas de instalar Xubuntu: (s / n)${endColour}"
read confirmacion

if [ $confirmacion == "s" ];
then
	sudo apt remove --purge -y libreoffice* xfburn atril xfce4-dict parole xfce4-taskmanager pidgin xfce4-screenshooter thunderbird catfish gnome-sudoku gnome-mines sgt-launcher ristretto gimp simple-scan

	sudo apt install nautilus -y > /dev/null 2>&1
	sudo apt remove --purge thunar -y > /dev/null 2>&1

	#Deshabilitar documentos recientes nautilus
	sudo rm ~/.local/share/recently-used.xbel
	sudo touch ~/.local/share/recently-used.xbel
	sudo chattr +i ~/.local/share/recently-used.xbel
	
else
	echo -e "${greenColour}Estas en otra version de Ubuntu${endColour}"
fi

########################################################################################################

echo -e "${turquoiseColour}Estas en VirtualBox: (s / n)${endColour}"
read confirmacion

if [ $confirmacion == "s" ];
then
	sudo dmesg | grep VirtualBox > /dev/null 2>&1
	if [ "$(echo $?)" == "0" ];
	then
		echo -e "${turquoiseColour}Estamos en una maquina virtual ${endColour}"
		sudo dpkg -l | grep -i "virtualbox-guest-x11" > /dev/null 2>&1

		if [ "$(echo $?)" == "1" ]
		then
			echo -e "${yellowColour}[*]${endColour}${greenColour}Instalando Guest Additions...${endColour}"
			# sudo add-apt-repository -y multiverse > /dev/null 2>&1
			sudo apt install -y virtualbox-guest-dkms virtualbox-guest-x11 > /dev/null 2>&1
			echo "${greenColour}Instalado ${endColour}"
		else
			echo -e "${blueColour}Guest Additions ${endColour}${greenColour}Instaladas${endColour}${endColour}"
		fi
	else 
		echo -e "${redColour}No estamos en una maquina virtual${endColour}"
	fi
else
	echo -e "${greenColour}No estas en VirtualBox${endColour}"
fi

########################################################################################################

echo -e "${turquoiseColour}Instalar ZSH?: (s / n)${endColour}"
read confirmacion

if [ $confirmacion == "s" ];
then
	sudo dpkg -l | grep -i "zsh" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		echo -e "${yellowColour}[*]${endColour}${grayColour}Instalando ZSH...${endColour}"
		sudo apt install -y zsh > /dev/null 2>&1
		sudo apt install -y git > /dev/null 2>&1
		wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
		git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions > /dev/null 2>&1
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting > /dev/null 2>&1
		chsh -s `which zsh`
		cd ~/
		sudo rm -R .zshrc
		touch .zshrc
		echo $cont | sudo -S chmod u=rw,g=r,o=r ~/.zshrc

		echo '
		export ZSH="/home/angel/.oh-my-zsh"

		ZSH_THEME="bira"

		plugins=(git
		zsh-autosuggestions
		zsh-syntax-highlighting
		)
		source $ZSH/oh-my-zsh.sh

		export PATH="$PATH:/home/angel/MisDocumentos/Scripts/Linux"

		' >> .zshrc

		echo -e "${greenColour} Instalado ${endColour}"
	else
		echo -e "${blueColour}ZSH ${endColour}${greenColour}Instalado${endColour}${endColour}"
	fi
else
	echo -e "${greenColour}No se va a instalar ZSH ${endColour}"
fi

########################################################################################################

echo -e "${turquoiseColour}Instalar Visual Studio Code?: (s / n)${endColour}"
read confirmacion

if [ $confirmacion == "s" ];
then
	sudo dpkg -l | grep -i "Code editing" > /dev/null 2>&1

	if [ "$(echo $?)" == "1" ];
	then
		echo -e "${yellowColour}[*]${endColour}${grayColour}Instalando Visual Studio Code...${endColour}"
		#Visual Studio Code
		wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - > /dev/null 2>&1
		sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /dev/null 2>&1
		sudo apt install -y code > /dev/null 2>&1
		sudo apt update -y > /dev/null 2>&1
		echo -e "${greenColour} Instalado ${endColour}"
	else
		echo -e "${blueColour}Visual Studio Code ${endColour}${greenColour}Instalado${endColour}${endColour}"
	fi
else
	echo -e "${greenColour}No se va a instalar Visual Studio Code ${endColour}"
fi

########################################################################################################

echo -e "${turquoiseColour}Instalar Net-tools?: (s / n)${endColour}"
read confirmacion

if [ $confirmacion == "s" ];
then
	sudo dpkg -l | grep -i "net-tools" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando net-tools...${endColour}"
		sudo apt install -y net-tools > /dev/null 2>&1
		echo -e "${greenColour} Instalado ${endColour}"
	else
		echo -e "${blueColour}Net-tools ${endColour}${greenColour}Instalado${endColour}${endColour}"
	fi
else
	echo -e "${greenColour}No se va a instalar Net-tools ${endColour}"
fi

########################################################################################################

echo -e "${turquoiseColour}Instalar SSH?: (s / n)${endColour}"
read confirmacion

if [ $confirmacion == "s" ];
then
	sudo dpkg -l | grep -i "openssh-client" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		echo -e "${yellowColour}[*]${endColour}${grayColour}Instalando openssh-client...${endColour}"
		sudo apt install -y openssh-client > /dev/null 2>&1
		sudo touch ~/.hushlogin
		echo -e "${greenColour}Instalado ${endColour}"
	else
		echo -e "${blueColour}Openssh-client ${endColour}${greenColour}Instalado${endColour}${endColour}"
	fi
else
	echo -e "${greenColour}No se va a instalar SSH ${endColour}"
fi

########################################################################################################

echo -e "${turquoiseColour}Instalar Tilix?: (s / n)${endColour}"
read confirmacion

if [ $confirmacion == "s" ];
then
	sudo dpkg -l | grep -i "tilix" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		echo -e "${yellowColour}[*]${endColour}${grayColour}Instalando Tilix...${endColour}"
		sudo apt install -y tilix > /dev/null 2>&1
		echo -e "${greenColour}Tilix Instalado ${endColour}"
	else
		echo -e "${blueColour}Tilix está ${endColour}${greenColour}Instalado${endColour}${endColour}"
	fi
else
	echo -e "${greenColour}No se va a instalar Tilix ${endColour}"
fi

########################################################################################################

echo -e "${turquoiseColour}Instalar Synaptic?: (s / n)${endColour}"
read confirmacion

if [ $confirmacion == "s" ];
then
	sudo dpkg -l | grep -i "synaptic" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		echo -e "${yellowColour}[*]${endColour}${grayColour}Instalando synaptic...${endColour}"
		sudo apt install -y synaptic > /dev/null 2>&1
		echo -e "${greenColour}Instalado ${endColour}"
	else
		echo -e "${blueColour}Synaptic está ${endColour}${greenColour}Instalado${endColour}${endColour}"
	fi
else
	echo -e "${greenColour}No se va a instalar Synaptic ${endColour}"
fi

########################################################################################################

echo -e "${turquoiseColour}Instalar gnome-tweak-tool?: (s / n)${endColour}"
read confirmacion

if [ $confirmacion == "s" ];
then
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
		echo -e "${greenColour}Instalado ${endColour}"

	else
		echo -e "${blueColour}Gnome-tweak-tool está ${endColour}${greenColour}Instalado${endColour}${endColour}"
	fi
else
	echo -e "${greenColour}No se va a instalar gnome-tweak-tool ${endColour}"
fi

########################################################################################################

echo -e "${turquoiseColour}Instalar Docker?: (s / n)${endColour}"
read confirmacion

if [ $confirmacion == "s" ];
then
	sudo dpkg -l | grep -i "docker" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
			echo $cont | sudo -S apt-get remove docker docker-engine docker.io containerd runc
			sudo apt-get update
			sudo apt-get install \
			apt-transport-https \
			ca-certificates \
			curl \
			gnupg \
			lsb-release
			curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
			echo \
		"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
		$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		sudo apt-get update
		sudo apt-get install docker-ce docker-ce-cli containerd.io
		sudo groupadd docker
		sudo usermod -aG docker $USER
		newgrp docker
	else
		echo -e "${blueColour}Docker está ${endColour}${greenColour}Instalado${endColour}${endColour}"
	fi
else
	echo -e "${greenColour}No se va a instalar Docker ${endColour}"
fi

########################################################################################################

echo -e "${turquoiseColour}Instalar Portainer.io en docker?: (s / n)${endColour}"
read confirmacion

if [ $confirmacion == "s" ];
then
	sudo dpkg -l | grep -i "docker" > /dev/null 2>&1
	if [ "$(echo $?)" == "0" ];
	then
		docker volume create portainer_data
		docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
	else
		echo -e "${blueColour}Docker no está ${endColour}${redColour}Instalado${endColour}${endColour}"
	fi
else
	echo -e "${greenColour}No se va a instalar portainer ${endColour}"
fi

########################################################################################################
echo -e "${turquoiseColour}Instalar No-Ip Agent?: (s / n)${endColour}"
read confirmacion

if [ $confirmacion == "s" ];
then
	cd /usr/local/src
	wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
	tar xzf noip-duc-linux.tar.gz
	cd noip-2.1.9-1
	make
	make install
	/usr/local/bin/noip2 -C

	# systemctl enable noip2.service (start on boot)
	# systemctl start noip2.service (start immediately)
	# systemctl status noip2.service (for status)

else
	echo -e "${greenColour}No se va a instalar portainer ${endColour}"
fi

########################################################################################################

# echo -e "${turquoiseColour}Instalar Latte-dock?: (s / n)${endColour}"
# read -s confirmacion

# if [ $confirmacion == "s" ];
# then
# 	sudo dpkg -l | grep -i "latte-dock" > /dev/null 2>&1
# 	if [ "$(echo $?)" == "1" ];
# 	then
# 		echo -e "${yellowColour}[*]${endColour}${grayColour}Instalando latte-dock...${endColour}"
# 		sudo apt install -y latte-dock > /dev/null 2>&1
# 		echo -e "${greenColour}latte-dock Instalado ${endColour}"
# 	else
# 		echo -e "${blueColour}Latte-dock está ${endColour}${greenColour}Instalado${endColour}${endColour}"
# 	fi
# else
# 	echo -e "${greenColour}No se va a instalar Latte-dock ${endColour}"
# fi

########################################################################################################

echo -e "${turquoiseColour}Instalar Sublime Text?: (s / n)${endColour}"
read confirmacion

if [ $confirmacion == "s" ];
then
	sudo dpkg -l | grep -i "sublime" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		echo -e "${yellowColour}[*]${endColour}${grayColour}Instalando Sublime Text...${endColour}"
		sudo apt upgrade -y > /dev/null 2>&1
		sudo apt update -y > /dev/null 2>&1
		wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - > /dev/null 2>&1
		sudo apt install apt-transport-https > /dev/null 2>&1
		echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list > /dev/null 2>&1
		sudo apt update -y > /dev/null 2>&1
		sudo apt install sublime-text -y > /dev/null 2>&1
		sudo apt update -y > /dev/null 2>&1
		echo -e "${greenColour}Sublime Text Instalado ${endColour}"
	else
		echo -e "${blueColour}Sublime Text está ${endColour}${greenColour}Instalado${endColour}${endColour}"
	fi
else
	echo -e "${greenColour}No se va a instalar Sublime Text ${endColour}"
fi

########################################################################################################

# echo -e "${turquoiseColour}Instalar XXX?: (s / n)${endColour}"
# read confirmacion

# if [ $confirmacion == "s" ];
# then
# 	sudo dpkg -l | grep -i "XXX" > /dev/null 2>&1
# 	if [ "$(echo $?)" == "1" ];
# 	then
# 		echo -e "${yellowColour}[*]${endColour}${grayColour}Instalando XXX...${endColour}"
# 		# sudo apt install -y latte-dock > /dev/null 2>&1
# 		echo -e "${greenColour}XXX Instalado ${endColour}"
# 	else
# 		echo -e "${blueColour}XXX está ${endColour}${greenColour}Instalado${endColour}${endColour}"
# 	fi
# else
# 	echo -e "${greenColour}No se va a instalar XXX ${endColour}"
# fi

########################################################################################################

echo -e "${turquoiseColour}Instalar reproductor parole?: (s / n)${endColour}"
read confirmacion

if [ $confirmacion == "s" ];
then
	sudo dpkg -l | grep -i "parole" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		echo -e "${yellowColour}[*]${endColour}${grayColour}Instalando parole...${endColour}"
		sudo apt-get install parole -y
		echo -e "${greenColour}parole Instalado ${endColour}"
	else
		echo -e "${blueColour}parole está ${endColour}${greenColour}Instalado${endColour}${endColour}"
	fi
else
	echo -e "${greenColour}No se va a instalar parole ${endColour}"
fi

########################################################################################################

sudo apt update -y > /dev/null 2>&1
sudo apt upgrade -y > /dev/null 2>&1
sudo apt update -y > /dev/null 2>&1

echo -e "${yellowColour}Proceso terminado ${endColour}"