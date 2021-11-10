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

function actualizarlimpiar()
{
	sudo apt update -y > /dev/null 2>&1
	sudo apt full-upgrade -y > /dev/null 2>&1
	sudo apt update -y > /dev/null 2>&1
	sudo apt autoremove -y > /dev/null 2>&1
	sudo apt --fix-broken install -y > /dev/null 2>&1
    rm -rf ~/.local/share/Trash/*
    # sudo rm -rf /tmp/*
    # sudo rm -vfr /tmp/* >/dev/null 2>&1
    # rm -vfr /var/tmp/* >/dev/null 2>&1
	# sudo apt unattended-upgrades
	# sudo dpkg-reconfigure --priority=low unattended-upgrades
}

function sistema ()
{
	sis=$(env|grep XDG_CURRENT_DESKTOP)

	if [[ $sis = "XDG_CURRENT_DESKTOP=XFCE" ]];
	then
		lsb_release -d | grep "Ubuntu" > /dev/null 2>&1
		if [ "$(echo $?)" == "0" ];
		then
			OS="Xubuntu"
		fi

		lsb_release -d | grep "Linux Mint" > /dev/null 2>&1
		if [ "$(echo $?)" == "0" ];
		then
			OS="Mint xfce"
		fi
	fi

	if [[ $sis = "XDG_CURRENT_DESKTOP=LXDE" ]];
	then
		lsb_release -d | grep "Raspbian"
		if [ "$(echo $?)" == "0" ];
		then
			OS="Rasbperry"
		fi
	fi

    if [[ $sis = "XDG_CURRENT_DESKTOP=GNOME" ]];
	then
        lsb_release -d | grep "Debian GNU/Linux 11"
		if [ "$(echo $?)" == "0" ];
		then
			OS="Debian11"
		fi
	fi

	if [[ $sis = "" ]];
	then
		OS="UbuntuServer"
	fi

	if [[ $sis = "XDG_CURRENT_DESKTOP=Pantheon" ]];
	then
        lsb_release -d | grep "elementary OS 5"
		if [ "$(echo $?)" == "0" ];
		then
		    OS="ElementaryOS5"
        fi
        lsb_release -d | grep "elementary OS 6"
		if [ "$(echo $?)" == "0" ];
		then
		    OS="ElementaryOS5"
        fi
	fi

	if [[ $sis = "XDG_CURRENT_DESKTOP=ubuntu:GNOME" ]];
	then
		OS="Ubuntu"
	fi
}

function ZSH ()
{
	sudo dpkg -l | grep -i "zsh" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		sudo apt install -y zsh > /dev/null 2>&1
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

		echo -e "${amarillo}[*]${endColour}${verde} ZSH Instalado${endColour}"
	fi
}

function PIP ()
{
	sudo pip3 install gspread
	sudo pip3 install selenium
	sudo pip3 install oauth2client
	sudo pip3 install paho-mqtt
}

function flaspak ()
{
    sudo apt install flatpak
    sudo apt install gnome-software
    sudo apt install gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

function RAID ()
{
	sudo dpkg -l | grep -i "mdadm" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
		sudo apt install mdadm -y > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde} Servidor RAID Instalado${endColour}"
	fi
}

function Onedriver ()
{
	sudo add-apt-repository ppa:jstaf/onedriver -y > /dev/null 2>&1
    sudo apt update -y > /dev/null 2>&1
    sudo apt install onedriver -y > /dev/null 2>&1
	echo -e "${amarillo}[*]${endColour}${verde} Onedriver Instalado${endColour}"
}


function Basicos () 
{
	echo " "
	echo -e "${lila}Instalando Programas...${endColour}"

	sudo apt install git -y > /dev/null 2>&1
	sudo apt install neofetch -y > /dev/null 2>&1
	sudo apt install synaptic -y > /dev/null 2>&1
	sudo apt install samba -y > /dev/null 2>&1
	sudo apt install wget -y > /dev/null 2>&1
    sudo apt install cockpit -y > /dev/null 2>&1
    echo 12AP3Nagz! | sudo -S systemctl restart cockpit

    sudo apt-get install build-essential gcc make perl dkms -y > /dev/null 2>&1
    sudo apt install software-properties-common apt-transport-https -y > /dev/null 2>&1
    sudo apt install rsync -y > /dev/null 2>&1
    
    sudo apt-get install lm-sensors -y > /dev/null 2>&1
    sudo apt install psensor -y > /dev/null 2>&1
    sudo apt-get install hddtemp -y > /dev/null 2>&1
    # sudo hddtemp /dev/sda 

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
	
	# sudo dpkg -l | grep -i "" > /dev/null 2>&1
	# if [ "$(echo $?)" == "1" ]
	# then
	# 	sudo apt install  -y > /dev/null 2>&1
	# echo -e "${amarillo}[*]${endColour}${verde} XXX ${endColour}"
	# fi

	ZSH
    PIP
	actualizarlimpiar
}

function Temas () 
{
	sudo dpkg -l | grep -i "sassc" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		sudo dpkg -l | grep -i "papirus-icon-theme" > /dev/null 2>&1
		if [ "$(echo $?)" == "1" ];
		then
			sudo add-apt-repository ppa:papirus/papirus -y > /dev/null 2>&1
			sudo apt update -y > /dev/null 2>&1
			sudo apt install papirus-icon-theme -y > /dev/null 2>&1
		fi
		sudo apt install sassc libglib2.0-dev-bin -y > /dev/null 2>&1
		actualizarlimpiar

		mkdir .themes
		mkdir .icons
		cd .themes/

		git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git > /dev/null 2>&1
		cd WhiteSur-gtk-theme/
		
		sudo apt update -y > /dev/null 2>&1
		sudo chmod 777 install.sh
		sudo ./install.sh > /dev/null 2>&1
		sudo ./install.sh -c dark -c light > /dev/null 2>&1
		sudo ./install.sh -i simple > /dev/null 2>&1
		cd ~/
	fi
	actualizarlimpiar
    echo -e "${amarillo}[*]${endColour}${verde} Temas Instalados ${endColour}"
}

function VM () 
{
	sudo dmesg | grep VirtualBox > /dev/null 2>&1
	if [ "$(echo $?)" == "0" ];
	then
		sudo dpkg -l | grep -i "virtualbox-guest-x11" > /dev/null 2>&1
		if [ "$(echo $?)" == "1" ];
		then
			sudo apt install virtualbox-guest-dkms virtualbox-guest-x11 -y > /dev/null 2>&1
			echo -e "${amarillo}[*]${endColour}${verde} Guest Additions Instaladas${endColour}"
		fi
	fi
}

########################## PROGRAMAS ##########################
function Gnome-tweaks ()
{
    sudo dpkg -l | grep -i "gnome-tweak-tool" > /dev/null 2>&1
    if [ "$(echo $?)" == "1" ];
    then
        sudo apt-get install gnome-tweak-tool -y > /dev/null 2>&1
        sudo apt install gnome-shell-extensions chrome-gnome-shell -y > /dev/null 2>&1
        echo -e "${amarillo}[*]${endColour}${verde} Gnome-tweak-tool Instalado ${endColour}"
    fi
}

function Plank () 
{
	sudo dpkg -l | grep -i "plank" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		sudo apt-get install plank -y > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde} Plank Instalado ${endColour}"
	fi
}

function SSH () 
{
	sudo apt install openssh-client openssh-server openssh-sftp-server -y > /dev/null 2>&1
    sudo apt install sshpass -y > /dev/null 2>&1
	sudo touch ~/.hushlogin
}

function Tilix () 
{
	sudo dpkg -l | grep -i "tilix" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		sudo apt install -y tilix > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde}Tilix Instalado ${endColour}"
	fi
}
		
function Sublime () 
{
	sudo dpkg -l | grep -i "sublime" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		actualizarlimpiar
		wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
		sudo apt-get install apt-transport-https -y > /dev/null 2>&1
		echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
		actualizarlimpiar
		sudo apt install sublime-text -y > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde} Sublime Text Instalado${endColour}"
	fi
}

function Webmin () 
{
	sudo dpkg -l | grep -i "webmin" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		actualizarlimpiar
        sudo wget -q http://www.webmin.com/jcameron-key.asc -O- | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] http://download.webmin.com/download/repository sarge contrib"
        sudo apt install webmin -y > /dev/snull 2>&1
        sudo /usr/share/webmin/changepass.pl /etc/webmin root 12AP3Nagz!
        # sudo nano -w /etc/webmin/miniserv.conf
		echo -e "${amarillo}[*]${endColour}${verde} webmin Instalado${endColour}"
	fi
}

function Stacer () 
{
	sudo dpkg -l | grep -i "stacer" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		sudo apt install stacer -y > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde} Stacer Instalado ${endColour}"
	fi
}

function Gparted () 
{
	sudo dpkg -l | grep -i "gparted" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		sudo apt install gparted -y > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde} Gparted Instalado ${endColour}"
	fi
}

function GnomeBoxes () 
{
	sudo apt-get install gnome-boxes qemu-kvm libvirt0 virt-manager bridge-utils -y > /dev/null 2>&1
	echo -e "${amarillo}[*]${endColour}${verde} Gnome Boxes Instalado ${endColour}"
}

function Instalacion ()
{
    clear

    Basicos

    sistema

    if [[ $OS == "Xubuntu" ]]
    then
        VM
        sudo apt remove --purge -y onboard mousepad gnome-font-viewer gucharmap info libreoffice* xfburn atril xfce4-dict xfce4-taskmanager pidgin xfce4-screenshooter thunderbird catfish gnome-sudoku gnome-mines sgt* ristretto gimp simple-scan > /dev/null 2>&1
        actualizarlimpiar

        sudo add-apt-repository ppa:xubuntu-dev/staging -y > /dev/null 2>&1
        actualizarlimpiar

        sudo apt install nomacs -y > /dev/null 2>&1
        sudo apt install gnome-system-monitor -y > /dev/null 2>&1
        sudo apt install transmission -y > /dev/null 2>&1
        sudo apt install gnome-disk-utility -y > /dev/null 2>&1
        
        Gparted
        Plank
        SSH
        Tilix
        Temas
        Stacer
        Sublime
        Webmin
        RAID

        echo -e "${turquesa}Cambiar gestos de archivos a nautilus: (s / n)${endColour}"
        read confirmacion

        if [ $confirmacion == "s" ];
        then
            sudo apt install nautilus -y > /dev/null 2>&1
            sudo apt remove --purge thunar -y > /dev/null 2>&1

            #Deshabilitar documentos recientes nautilus
            sudo rm ~/.local/share/recently-used.xbel
            sudo touch ~/.local/share/recently-used.xbel
            sudo chattr +i ~/.local/share/recently-used.xbel
        fi
    fi

    if [[ $OS == "Debian11" ]]
    then
        sudo apt remove --purge -y libreoffice-common tali gnome-taquin gnome-maps gnome-weather gnome-sudoku gnome-robots gnome-tetravex gnome-nibbles quadrapassel swell-foop aisleriot gnome-mahjongg 
        VM
        SSH
        Tilix
        Temas
        Gnome-tweaks
        
        actualizarlimpiar
    
    fi

    if [[ $OS == "Rasbperry" ]]
    then
        sudo apt remove --purge thonny -y 
        sudo apt remove --purge geany -y
        sudo apt install thunar -y
        actualizarlimpiar
        sudo apt dist-upgrade -y 
        sudo rpi-update -y

        SSH
        Tilix
        Temas
        Plank
        actualizarlimpiar
    fi

    if [[ $OS == "Mint xfce" ]]
    then
        VM
        sudo apt remove --purge -y libreoffice-core libreoffice-common libreoffice-base-core onboard mintreport drawing sticky hypnotix simple-scan hexchat xfce4-dict xed gnome-font-viewer xreader thunderbird gnome-logs redshift-gtk gucharmap -y > /dev/null 2>&1
        actualizarlimpiar
        
        Gparted
        Plank
        SSH
        Tilix
        Temas
        Stacer
        Sublime
    fi

    if [[ $OS == "UbuntuServer" ]]
    then
        echo "Instalacion de programas en ubuntu server: "
        SSH
        Webmin
        RAID
    fi

    if [[ $OS == "Ubuntu" ]]
    then
        Gparted
        SSH
        Tilix
        Temas
        Stacer
        Sublime
    fi

    if [[ $OS == "ElementaryOS5" ]]
    then
        VM
        sudo apt install software-properties-common -y > /dev/null 2>&1
        sudo add-apt-repository ppa:philip.scott/elementary-tweaks -y
        sudo apt-get install elementary-tweaks -y > /dev/null 2>&1
        actualizarlimpiar
        sudo apt remove --purge epiphany-browser -y > /dev/null 2>&1
        sudo apt install firefox -y > /dev/null 2>&1

        actualizarlimpiar

        sudo apt-get install build-essential module-assistant -y > /dev/null 2>&1
        sudo m-a prepare -y > /dev/null 2>&1
        sudo apt install libgconf2-dev libpolkit-gobject-1-dev libswitchboard-2.0-dev elementary-sdk -y > /dev/null 2>&1
        SSH
        Tilix
        Sublime
        Synaptic
        Temas
        Stacer
    fi

    if [[ $OS == "ElementaryOS6" ]]
    then
        VM
        sudo apt install software-properties-common -y > /dev/null 2>&1
        sudo add-apt-repository ppa:philip.scott/pantheon-tweaks -y > /dev/null 2>&1
        actualizarlimpiar
        sudo apt-get install pantheon-tweaks -y > /dev/null 2>&1

        sudo apt remove --purge epiphany-browser -y > /dev/null 2>&1
        sudo apt install firefox -y > /dev/null 2>&1

        actualizarlimpiar

        sudo apt-get install build-essential module-assistant -y > /dev/null 2>&1
        sudo m-a prepare -y > /dev/null 2>&1
        sudo apt install libgconf2-dev libpolkit-gobject-1-dev libswitchboard-2.0-dev elementary-sdk -y > /dev/null 2>&1
        SSH
        Tilix
        Sublime
        Synaptic
        Temas
        Stacer
    fi


    #################################################################

    echo -e "${turquesa}Instalar Visual Studio Code?: (s / n)${endColour}"
    read confirmacion

    if [ $confirmacion == "s" ];
    then
        sudo dpkg -l | grep -i "Code editing" > /dev/null 2>&1

        if [ "$(echo $?)" == "1" ];
        then
            #Visual Studio Code
            wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - > /dev/null 2>&1
            sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /dev/null 2>&1
            sudo apt install -y code > /dev/null 2>&1
            sudo apt update -y > /dev/null 2>&1
            echo -e "${amarillo}[*]${endColour}${verde} Visual Studio Code Instalado ${endColour}"
        fi
    fi

    #################################################################

    # echo -e "${turquoiseColour}Instalar SSH?: (s / n)${endColour}"
    # read confirmacion

    # if [ $confirmacion == "s" ];
    # then
    # 	sudo dpkg -l | grep -i "openssh-client" > /dev/null 2>&1
    # 	if [ "$(echo $?)" == "1" ];
    # 	then
    # 		echo -e "${yellowColour}[*]${endColour}${grayColour}Instalando openssh-client...${endColour}"

    # 		echo -e "${greenColour}Instalado ${endColour}"
    # 	else
    # 		echo -e "${blueColour}Openssh-client ${endColour}${greenColour}Instalado${endColour}${endColour}"
    # 	fi
    # fi

    #################################################################

    echo -e "${turquesa}Instalar VNC?: (s / n)${endColour}"
    read confirmacion

    if [ $confirmacion == "s" ];
    then
        sudo dpkg -l | grep -i "vnc-server" > /dev/null 2>&1
        if [ "$(echo $?)" == "1" ];
        then
            wget https://www.realvnc.com/download/file/vnc.files/VNC-Server-6.8.0-Linux-x64.deb
            sudo dpkg -i VNC-Server-6.8.0-Linux-x64.deb > /dev/null 2>&1
            #sudo /etc/vnc/vncelevate "Enable VNC Server Service Mode" /etc/vnc/vncservice start vncserver-x11-serviced
            sudo rm -R VNC-Server-6.8.0-Linux-x64.deb
            sudo apt update -y
            echo -e "${amarillo}[*]${endColour}${verde} VNC Instalado ${endColour}"
        fi
    fi

    #################################################################

    echo -e "${turquesa}Instalar Veracrypt?: (s / n)${endColour}"
    read confirmacion

    if [ $confirmacion == "s" ];
    then
        sudo dpkg -l | grep -i "veracrypt" > /dev/null 2>&1
        if [ "$(echo $?)" == "1" ];
        then
            wget https://launchpad.net/veracrypt/trunk/1.24-update7/+download/veracrypt-1.24-Update7-Ubuntu-20.04-amd64.deb
            sudo dpkg -i veracrypt-1.24-Update7-Ubuntu-20.04-amd64.deb > /dev/null 2>&1
            sudo rm -R veracrypt-1.24-Update7-Ubuntu-20.04-amd64.deb

            actualizarlimpiar
            echo -e "${amarillo}[*]${endColour}${verde} Veracrypt Instalado ${endColour}"
        fi
    fi

    #################################################################

    echo -e "${turquesa}Instalar Docker?: (s / n)${endColour}"
    read confirmacion

    if [ $confirmacion == "s" ];
    then
        sudo dpkg -l | grep -i "docker" > /dev/null 2>&1
        if [ "$(echo $?)" == "1" ];
        then
            sudo apt-get remove docker docker-engine docker.io containerd runc
            sudo apt-get update -y 
            sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release 
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
            echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
            sudo apt-get update -y
            sudo apt-get install -y docker-ce docker-ce-cli containerd.io
            sudo apt-get update -y

            #Docker compose
            sudo apt install docker-compose -y > /dev/null 2>&1

            #Kubernetes
            sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl > /dev/null 2>&1
            curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
            echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
            sudo apt-get update -y > /dev/null 2>&1
            sudo apt-get install -y kubectl > /dev/null 2>&1
            echo -e "${amarillo}[*]${endColour}${verde} Docker Instalado ${endColour}"
        fi
    fi

    #################################################################

    echo -e "${turquesa}Instalar Portainer.io en docker?: (s / n)${endColour}"
    read confirmacion

    if [ $confirmacion == "s" ];
    then
        sudo dpkg -l | grep -i "docker" > /dev/null 2>&1
        if [ "$(echo $?)" == "0" ];
        then
            sudo docker volume create portainer_data 
            sudo docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
            echo -e "${amarillo}[*]${endColour}${verde} Portainer.io Instalado ${endColour}"
        else
            echo -e "${rojo}Docker no está Instalado ${endColour}"
        fi
    fi

    #################################################################

    echo -e "${turquesa}Instalar Home Assistant en docker?: (s / n)${endColour}"
    read confirmacion

    if [ $confirmacion == "s" ];
    then
        sudo dpkg -l | grep -i "docker" > /dev/null 2>&1
        if [ "$(echo $?)" == "0" ];
        then
            sudo docker run -d --name homeassistant --privileged --restart=unless-stopped -e TZ=SPAIN -v $HOME/homeassistant/config:/config --network=host ghcr.io/home-assistant/home-assistant:stable
            echo -e "${amarillo}[*]${endColour}${verde} Home Assistant Instalado ${endColour}"
        else
            echo -e "${rojo}Docker no está Instalado ${endColour}"
        fi
    fi

    #################################################################

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

    #################################################################

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

    #################################################################

    actualizarlimpiar

    git config --global user.name angelgz89
    git config --global user.email agz2712@gmail.com

    # sudo apt install ufw -y > /dev/null 2>&1
    # sudo ufw enable
    # sudo ufw allow 22
    # sudo ufw allow 80
    # sudo ufw allow 445
    # sudo ufw allow http
    # sudo ufw disable

    # sudo ufw deny 80
    # sudo ufw status numbered
    # sudo nano /etc/default/ufw

    # sudo apt-get install localepurge

    # mosquitto_sub -h 192.168.1.111 -t "topic"
    # mosquitto_pub -h 192.168.1.111 -t "topic" -m "Mi primer mensaje usando MQTT"


    #cd /etc/apt/sources.list.d 

    echo -e "${amarillo}Proceso terminado ${endColour}"

    Pulseunateclaparacontinuar

}

function creacionScripts () 
{
	cd ~
	DIRECTORIO=Scripts
	if [ -d "$DIRECTORIO" ];
	then
			cd Scripts/
	else
			mkdir Scripts
			cd Scripts
	fi
}

function Video-dummy ()
{
    sudo apt install xserver-xorg-video-dummy -y > /dev/null 2>&1
    cd /usr/share/X11/xorg.conf.d/
    sudo touch xorg.conf
    sudo chmod g+w,o+w xorg.conf 
    echo '
    Section "Monitor"
    Identifier "Monitor0"
    HorizSync 28.0-80.0
    VertRefresh 48.0-75.0
    Modeline "1920x1080_60.00" 172.80 1920 2040 2248 2576 1080 1081 1084 1118 -HSync +Vsync

    EndSection
        Section "Device"
        Identifier "Card0"
        Driver "dummy"
        VideoRam 256000
    EndSection

    Section "Screen"
        DefaultDepth 24
        Identifier "Screen0"
        Device "Card0"
        Monitor "Monitor0"
        SubSection "Display"
            Depth 24
            Modes "1920x1080_60.00"
        EndSubSection
    EndSection' > xorg.conf
    cd ~
}

###################################################

function Pulseunateclaparacontinuar ()
{
    echo -e "${verde}Pulse cualquier tecla para continuar${endColour}"
    read a
    case "$a" in *)
        clear
        Menu
    esac
}

function PulseunateclaparacontinuarM ()
{
    echo -e "${verde}Pulse cualquier tecla para continuar${endColour}"
    read a
    case "$a" in *)
        clear
        Mantenimiento
    esac
}

function PulseunateclaparacontinuarG ()
{
    echo -e "${verde}Pulse cualquier tecla para continuar${endColour}"
    read a
    case "$a" in *)
        clear
        GestionServicios
    esac
}

function Salir ()
{
    clear
    echo ""
    echo -e "${verde}Gracias por utilizar el programa ${endColour}"
    echo -e "${verde}Hasta luego! ${endColour}"
    echo ""
    
    sudo dpkg -l | grep -i "docker" > /dev/null 2>&1
    if [ "$(echo $?)" == "0" ];
    then
        sudo usermod -aG docker $USER
        newgrp docker
    fi

    return 0
}

function Entradilla ()
{
	clear
	echo "---------------------------"
	echo -e "${amarillo}Programa de configuracion y mantenimiento de sistemas linux ${endColour}"
	echo "---------------------------"
    echo ""
}

function GestionServicios ()
{
    Entradilla
    echo "---------------------------"
	echo -e "${amarillo} GESTION ${endColour}"
	echo "---------------------------"
    echo ""
	echo -e "${turquesa}1: Reiniciar servicio SSH ${endColour}"
	echo -e "${turquesa}2: Reiniciar servicio SMB ${endColour}"
	echo -e "${turquesa}3: Acceder configuracion SMB ${endColour}"
    echo -e "${turquesa}4: Carpetas compartidas SMB ${endColour}"
	echo -e "${turquesa}5: Instalar Video-dummy ${endColour}"
	echo -e "${turquesa}6: Configurar carpeta SMB ${endColour}"
    echo ""
	echo -e "${turquesa}0: Volver al Menu principal ${endColour}"
    echo ""
	echo "-----------------------------"
    echo -e "${verde}Por favor, ingrese su operación ${endColour}"
    read a
	
    while [ $a != "0" ] && [ $a != "1" ] && [ $a != "2" ] && [ $a != "3" ] && [ $a != "4" ] && [ $a != "5" ] && [ $a != "6" ]
    do
        echo -e "${rojo}Entrada incorrecta, por favor vuelva a ingresar una opcion ${endColour}"
		read a
    done
	
	case "$a" in 
	0)
        clear
        Menu;;
	1)
		sudo /etc/init.d/ssh restart
        sleep 1s
        GestionServicios;;
	2)
        sudo /etc/init.d/smbd restart
        sleep 1s
		GestionServicios;;
    3)
        sudo nano /etc/samba/smb.conf
		GestionServicios;;  
	4)		
        clear
        testparm
		PulseunateclaparacontinuarG;;
	5)
        sudo dpkg -l | grep -i "vnc-server" > /dev/null 2>&1
        if [ "$(echo $?)" == "1" ];
        then
            echo ""
            echo -e "${rojo}Primero habria que instalar VNC-Server, si no no podrias accceder al pc ${endColour}"
            echo -e "${verde}Instalando VNC Server... ${endColour}"
            wget https://www.realvnc.com/download/file/vnc.files/VNC-Server-6.7.4-Linux-x64.deb
            sudo dpkg -i VNC-Server-6.7.4-Linux-x64.deb > /dev/null 2>&1
            #sudo /etc/vnc/vncelevate "Enable VNC Server Service Mode" /etc/vnc/vncservice start vncserver-x11-serviced
            sudo rm -R VNC-Server-6.7.4-Linux-x64.deb
            sudo apt update -y
            echo -e "${amarillo}[*]${endColour}${verde} VNC Instalado ${endColour}"
            echo -e "${verde}Ahora se va a instalar el Dummy ${endColour}"
            Video-dummy
            sleep 2s
            echo -e "${rojo} Si quieres que se apliquen los cambios es necesario reiniciar ${endColour}"
        else
            Video-dummy
            sleep 2s
            echo -e "${rojo} Si quieres que se apliquen los cambios es necesario reiniciar ${endColour}"
        fi
		GestionServicios;;
    6)
        sudo echo '
        [Angel] 
        comment = Carpeta Compartida 
        path = /home/angel 
        browsable = yes 
        writable = yes 
        guest ok = no 
        read only = no 
        valid users = @angel 
        create mask = 0777 
        directory mask = 0777' >> /etc/samba/smb.conf
        echo "Done"
        GestionServicios;;
	esac
}

function Scripts ()
{
    Entradilla
	echo -e "${turquesa}1: Crear script ZSH_history_fix? ${endColour}"
	echo -e "${turquesa}2: Crear script temperaturas${endColour}"
	echo -e "${turquesa}3: Crear script IP Publica${endColour}"
	echo -e "${turquesa}4:  ${endColour}"
	echo -e "${turquesa}5:  ${endColour}"
    echo ""
	echo -e "${turquesa}0: Volver al Menu principal ${endColour}"
    echo ""
	echo "-----------------------------"
    echo -e "${verde}Por favor, ingrese su operación ${endColour}"
    read a
	
    while [ $a != "0" ] && [ $a != "1" ] && [ $a != "2" ] && [ $a != "3" ] && [ $a != "4" ] && [ $a != "5" ]
    do
        echo -e "${rojo}Entrada incorrecta, por favor vuelva a ingresar una opcion ${endColour}"
		read a
    done
	
	case "$a" in 
	0)
        clear
        Menu;;
	1)
        creacionScripts
        touch zsh_history_fix.sh
        sudo echo '
        #!/bin/zsh
        mv ~/.zsh_history ~/.zsh_history_bad
        strings .zsh_history_bad > .zsh_history
        fc -R ~/.zsh_history
        rm ~/.zsh_history_bad' > zsh_history_fix.sh
        sudo chmod 777 zsh_history_fix.sh
        cd ~
        echo -e "${verde}Script Creado ${endColour}"
        sleep 1s
        Scripts;;
	2)
        creacionScripts
        touch temperatura.sh
        sudo echo '
        #!/bin/bash
        cpuTemp=$(cat /sys/class/thermal/thermal_zone0/temp)
        #gpuTemp=$(vcgencmd measure_temp)
        echo "Temperatura CPU = $((cpuTemp/1000))ºC"' > temperatura.sh
        sudo chmod 777 temperatura.sh
        cd ~
        echo -e "${verde}Script Creado ${endColour}"
        sleep 1s
        Scripts;;
	3)
        creacionScripts
        touch IP.sh
        sudo echo 'curl ifconfig.me/ip' > IP.sh
        sudo chmod 777 IP.sh
        cd ~
        echo -e "${verde}Script Creado ${endColour}"
        sleep 1s
        Scripts;;
	4)	
        echo -e "${verde}Script Creado ${endColour}"
        sleep 1s
        Scripts;;
	5)
        echo -e "${verde}Script Creado ${endColour}"
        sleep 1s
        Scripts;;
	esac
}

function Mantenimiento ()
{
    Entradilla
     echo "---------------------------"
	echo -e "${amarillo} MANTENIMIENTO ${endColour}"
	echo "---------------------------"
    echo ""
	echo -e "${turquesa}1: Ver temperatura del sistema ${endColour}"
	echo -e "${turquesa}2: Ocupacion disco duro ${endColour}"
	echo -e "${turquesa}3: Procesos con mas consumo de memoria ${endColour}"
	echo -e "${turquesa}4: Usuarios registrados ${endColour}"
    echo -e "${turquesa}5: Ips ${endColour}"
	echo -e "${turquesa}6: Limpieza ${endColour}"
    echo -e "${turquesa}7: Eliminar repositorios ${endColour}"
    echo -e "${turquesa}8: Borrar informe de errores ${endColour}"
    echo ""
	echo -e "${turquesa}0: Volver al Menu principal ${endColour}"
    echo ""
	echo "-----------------------------"
    echo -e "${verde}Por favor, ingrese su operación ${endColour}"
    read a
	
    while [ $a != "0" ] && [ $a != "1" ] && [ $a != "2" ] && [ $a != "3" ] && [ $a != "4" ] && [ $a != "5" ] && [ $a != "6" ] && [ $a != "7" ] && [ $a != "8" ] 
    do
        echo -e "${rojo}Entrada incorrecta, por favor vuelva a ingresar una opcion ${endColour}"
		read a
    done
	
	case "$a" in 
	0)
        clear
        Menu;;
	1)
        clear
		sensors
        PulseunateclaparacontinuarM;;
	2)
        clear
        df -h
		PulseunateclaparacontinuarM;;
	3)
        clear
        ps -eo %mem,%cpu,comm --sort=-%mem | head -n 6
		PulseunateclaparacontinuarM;;
	4)	
        clear
        who
		PulseunateclaparacontinuarM;;
    5)	
        clear
        ifconfig
		PulseunateclaparacontinuarM;;    
	6)
        echo -e "${verde}Limpiando... ${endColour}"
        sudo apt update -y > /dev/null 2>&1
        sudo apt upgrade -y > /dev/null 2>&1
        sudo apt update -y > /dev/null 2>&1
        sudo apt full-upgrade -y > /dev/null 2>&1

        sudo apt autoremove -y > /dev/null 2>&1
        sudo apt --fix-broken install -y > /dev/null 2>&1

        sudo apt clean -y > /dev/null 2>&1
        sudo apt autoclean -y > /dev/null 2>&1
        sudo apt purge -y > /dev/null 2>&1

        #sudo rm -f /var/log/*.old /var/log/*.gz /var/log/apt/* /var/log/auth* /var/log/daemon* /var/log/debug* /var/log/dmesg* /var/log/dpkg* /var/log/kern* /var/log/messages* /var/log/syslog* /var/log/user* /var/log/Xorg* /var/crash/*
        sudo rm -rf /home/*/.local/share/Trash/*/**
        sudo rm -rf /root/.local/share/Trash/*/**
        sudo sync && sudo sysctl -w vm.drop_caches=3 > /dev/null 2>&1
        sudo sync
        sudo echo "" > ~/.bash_history
        clear
        echo -e "${verde}Sistema limpio ${endColour}"
		PulseunateclaparacontinuarM;;
    7)	
        clear
        cd /etc/apt/sources.list.d/
		PulseunateclaparacontinuarM;;

    8)
        sudo rm -r /var/crash
        PulseunateclaparacontinuarM;;
	esac
}

function Menu
{
    Entradilla
	echo -e "${turquesa}1: Módulo de Post-instalacion de sistemas ${endColour}"
	echo -e "${turquesa}2: Módulo de Gestión de servicios ${endColour}"
	echo -e "${turquesa}3: Módulo de Creación de scripts ${endColour}"
	echo -e "${turquesa}4: Módulo de Mantenimiento del sistema ${endColour}"
	echo -e "${turquesa}5: Módulo de  ${endColour}"
    echo -e "${turquesa}6: Reiniciar ${endColour}"
    echo ""
	echo -e "${turquesa}0: Salir del Script ${endColour}"
    echo ""
	echo "-----------------------------"
    echo -e "${verde}Por favor, ingrese su operación ${endColour}"
    read a
	
    while [ $a != "0" ] && [ $a != "1" ] && [ $a != "2" ] && [ $a != "3" ] && [ $a != "4" ] && [ $a != "5" ] && [ $a != "6" ]
    do
        echo -e "${rojo}Entrada incorrecta, por favor vuelva a ingresar una opcion ${endColour}"
		read a
    done
	
	case "$a" in 
	0)
        Salir;;
	1)
		Instalacion;;
	2)
		GestionServicios;;
	3)
		Scripts;;
	4)	
		Mantenimiento;;
	5)
		;;
    6)
		sudo reboot;;   
	esac
}

###############################################

Entradilla
echo -e "${lila}Por favor, introduce la contraseña de administrador para usar el programa: ${endColour}"
read -s cont
clear

Entradilla
echo -e "${turquesa}Actualizando el sistema${endColour}"
echo $cont | sudo -S apt update -y > /dev/null 2>&1
actualizarlimpiar
clear

Entradilla
echo -e "${verde}Sistema actualizado${endColour}"
echo ""

Pulseunateclaparacontinuar



# Instalar certificados SSL
# https://certbot.eff.org/lets-encrypt/ubuntufocal-other
# 0 0 * * 0 /usr/bin/letsencrypt certonly --email "my-email-address" --agree-tos --renew-by-default --webroot -w /home/deltik/public_html/ -d deltik.org
