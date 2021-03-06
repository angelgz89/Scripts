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

function actualizarlimpiar()
{
	sudo apt update -y > /dev/null 2>&1
	sudo apt full-upgrade -y > /dev/null 2>&1
	sudo apt update -y > /dev/null 2>&1
	sudo apt autoremove -y > /dev/null 2>&1
	sudo apt --fix-broken install -y > /dev/null 2>&1
    #rm -rf ~/.local/share/Trash/*
    # sudo rm -rf /tmp/*
    # sudo rm -vfr /tmp/* >/dev/null 2>&1
    # rm -vfr /var/tmp/* >/dev/null 2>&1
	# sudo apt unattended-upgrades
	# sudo dpkg-reconfigure --priority=low unattended-upgrades
}

#########################
#RECONOCIMIENTO DEL SISTEMA
#########################

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


    lsb_release -d | grep "Raspbian" > /dev/null 2>&1
    if [ "$(echo $?)" == "0" ];
    then
        OS="Rasbperry"
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
		    OS="ElementaryOS6"
        fi
	fi

	if [[ $sis = "XDG_CURRENT_DESKTOP=ubuntu:GNOME" ]];
	then
		OS="Ubuntu"
	fi
}

#########################

function Sistemas ()
{
    sistema

    if [[ $OS == "Xubuntu" ]]
    then
        sudo apt remove --purge -y onboard mousepad gnome-font-viewer gucharmap info libreoffice-base-core xfburn atril xfce4-dict xfce4-taskmanager pidgin xfce4-screenshooter thunderbird catfish gnome-sudoku gnome-mines sgt-launcher ristretto gimp simple-scan > /dev/null 2>&1
        actualizarlimpiar

        sudo add-apt-repository ppa:xubuntu-dev/staging -y > /dev/null 2>&1
        actualizarlimpiar

        sudo apt install nomacs -y > /dev/null 2>&1
        sudo apt install gnome-system-monitor -y > /dev/null 2>&1
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
        transmission

        actualizarlimpiar
    fi

    if [[ $OS == "Debian11" ]]
    then
        sudo apt remove --purge -y libreoffice-common tali gnome-taquin gnome-maps gnome-weather gnome-sudoku gnome-robots gnome-tetravex gnome-nibbles quadrapassel swell-foop aisleriot gnome-mahjongg

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

        actualizarlimpiar
    fi

    if [[ $OS == "Mint xfce" ]]
    then
        sudo apt remove --purge -y libreoffice-core libreoffice-common libreoffice-base-core onboard mintreport drawing sticky hypnotix simple-scan hexchat xfce4-dict xed gnome-font-viewer xreader thunderbird gnome-logs redshift-gtk gucharmap -y > /dev/null 2>&1
        actualizarlimpiar
        
    fi

    if [[ $OS == "UbuntuServer" ]]
    then
        echo ""
    fi

    if [[ $OS == "Ubuntu" ]]
    then
        echo ""
    fi

    if [[ $OS == "ElementaryOS5" ]]
    then
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
    fi

    if [[ $OS == "ElementaryOS6" ]]
    then
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



    actualizarlimpiar

    #git config --global user.name angelgz89
    #git config --global user.email agz2712@gmail.com

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

#########################
#Mantenimiento
#########################

function configuraWOL ()
{
    echo interfaz?
    read interfaz

    echo "Por favor, introduce la contraseña de administrador para usar el programa:"
    read -s cont

    echo $cont | sudo -S apt update -y
    sudo apt install ethtool -y
    sudo ethtool -s $interfaz wol g
    sudo apt install wakeonlan -y

    touch wol.service

    echo '[Unit]
    Description=Configure Wake On LAN

    [Service]
    Type=oneshot
    ExecStart=/sbin/ethtool -s '$interfaz' wol g

    [Install]
    WantedBy=basic.target' >> wol.service

    sudo cp wol.service /etc/systemd/system/

    rm -R wol.service

    sudo systemctl daemon-reload
    sudo systemctl enable wol.service
    sudo systemctl start wol.service
}

#########################
#PROGRAMAS
#########################

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
		echo -e "${amarillo}[*]${endColour}${verde} Webmin Instalado${endColour}"
	fi
}

function transmission () 
{
	sudo dpkg -l | grep -i "transmission" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
        sudo apt install transmission -y > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde} Transmission Instalado${endColour}"
	fi
}


function Onedriver ()
{
	sudo add-apt-repository ppa:jstaf/onedriver -y > /dev/null 2>&1
    sudo apt update -y > /dev/null 2>&1
    sudo apt install onedriver -y > /dev/null 2>&1
	echo -e "${amarillo}[*]${endColour}${verde} Onedriver Instalado${endColour}"
}

function synaptic () 
{
    sudo dpkg -l | grep -i "synaptic" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
        sudo apt install synaptic -y > /dev/null 2>&1
        echo -e "${amarillo}[*]${endColour}${verde} Synaptic Instalado${endColour}"
    fi
}

function temas () 
{
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

function Tilix () 
{
	sudo dpkg -l | grep -i "tilix" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		sudo apt install -y tilix > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde} Tilix Instalado ${endColour}"
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
		echo -e "${amarillo}[*]${endColour}${verde} Webmin Instalado${endColour}"
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

function VisualStudio ()
{
    sudo dpkg -l | grep -i "Code editing" > /dev/null 2>&1
    if [ "$(echo $?)" == "1" ];
    then
        #Visual Studio Code
        wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - > /dev/null 2>&1
        sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /dev/null 2>&1
        sudo apt install -y code > /dev/null 2>&1
        echo -e "${amarillo}[*]${endColour}${verde} Visual Studio Code Instalado ${endColour}"
    fi
}

function VNC ()
{
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
}

function Veracrypt ()
{
    sudo dpkg -l | grep -i "veracrypt" > /dev/null 2>&1
    if [ "$(echo $?)" == "1" ];
    then
        wget https://launchpad.net/veracrypt/trunk/1.24-update7/+download/veracrypt-1.24-Update7-Ubuntu-20.04-amd64.deb
        sudo dpkg -i veracrypt-1.24-Update7-Ubuntu-20.04-amd64.deb > /dev/null 2>&1
        sudo rm -R veracrypt-1.24-Update7-Ubuntu-20.04-amd64.deb

        actualizarlimpiar
        echo -e "${amarillo}[*]${endColour}${verde} Veracrypt Instalado ${endColour}"
    fi
}

function docker ()
{
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
}

#########################

function NOIP ()
{
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
}

function samba () 
{
    sudo apt install samba -y > /dev/null 2>&1
    echo -e "${amarillo}[*]${endColour}${verde} Samba Instalado${endColour}"
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

#########################

function terminal () 
{
    sudo apt install python3 python3-pip -y > /dev/null 2>&1
    sudo pip3 install gspread > /dev/null 2>&1
	sudo pip3 install selenium > /dev/null 2>&1
	sudo pip3 install oauth2client > /dev/null 2>&1
	sudo pip3 install python-dateutil > /dev/null 2>&1
	sudo pip3 install paho-mqtt > /dev/null 2>&1
    echo -e "${amarillo}[*]${endColour}${verde} Python Instalado${endColour}"

    sudo apt install openssh-client openssh-server openssh-sftp-server -y > /dev/null 2>&1
    sudo apt install sshpass -y > /dev/null 2>&1
	sudo touch ~/.hushlogin
    echo -e "${amarillo}[*]${endColour}${verde} SSH Instalado${endColour}"

    sudo apt install git -y > /dev/null 2>&1
    echo -e "${amarillo}[*]${endColour}${verde} GIT Instalado${endColour}"

    sudo apt install rsync -y > /dev/null 2>&1
    echo -e "${amarillo}[*]${endColour}${verde} Rsync Instalado${endColour}"

    sudo apt install wget -y > /dev/null 2>&1
    echo -e "${amarillo}[*]${endColour}${verde} WGET Instalado${endColour}"

    sudo dpkg -l | grep -i "neofetch" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
        sudo apt install neofetch -y > /dev/null 2>&1
        echo -e "${amarillo}[*]${endColour}${verde} Neofetch Instalado${endColour}"
    fi

    sudo dpkg -l | grep -i "sensors" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
        sudo apt-get install lm-sensors -y > /dev/null 2>&1
        echo -e "${amarillo}[*]${endColour}${verde} Sensors Instalado${endColour}"
    fi

	sudo dpkg -l | grep -i "binutils" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
		sudo apt install binutils -y > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde} Binutils Instalado${endColour}"
	fi

	sudo dpkg -l | grep -i "mosquitto" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
		sudo apt install mosquitto mosquitto-clients -y > /dev/null 2>&1
		echo -e "${amarillo}[*]${endColour}${verde} Mosquitto Instalado${endColour}"
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

    sudo dpkg -l | grep -i "cockpit" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
        sudo apt install cockpit -y > /dev/null 2>&1
        echo $cont | sudo -S systemctl restart cockpit
        echo -e "${amarillo}[*]${endColour}${verde} Cockpit Instalado${endColour}"
    fi

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

    # sudo dpkg -l | grep -i "" > /dev/null 2>&1
	# if [ "$(echo $?)" == "1" ]
	# then

    # fi

    mkdir ~/btop
    cd ~/btop
    if [ $(uname -m) == "x86_64" ];
    then
        wget https://github.com/aristocratos/btop/releases/download/v1.0.24/btop-1.0.24-x86_64-linux-musl.tbz > /dev/null 2>&1
        tar -xjf btop-1.0.24-x86_64-linux-musl.tbz > /dev/null 2>&1
    fi

    if [ $(uname -m) == "armv7l" ];
    then
        wget https://github.com/aristocratos/btop/releases/download/v1.0.24/btop-1.0.24-armv7l-linux-musleabihf.tbz > /dev/null 2>&1
        tar -xjf btop-1.0.24-armv7l-linux-musleabihf.tbz > /dev/null 2>&1
    fi
    ./install.sh > /dev/null 2>&1
    cd ..
    rm -R btop
    echo -e "${amarillo}[*]${endColour}${verde} Btop Instalado${endColour}"

    #sudo apt-get install build-essential gcc make perl dkms -y > /dev/null 2>&1
    #sudo apt install software-properties-common apt-transport-https -y > /dev/null 2>&1
    echo -e "${amarillo}[*]${endColour}${verde} Accesorios Instalados${endColour}"
}

#########################

function instalacion ()
{
    clear
    echo "---------------------------"
	echo -e "${amarillo} PROGRAMAS PARA INSTALAR ${endColour}"
	echo "---------------------------"
	echo -e "${turquesa}1: Tilix ${endColour}"
	echo -e "${turquesa}2: Sublime Text ${endColour}"
	echo -e "${turquesa}3: Docker ${endColour}"
    echo -e "${turquesa}4: Veracrypt ${endColour}"
	echo -e "${turquesa}5: VNC ${endColour}"
	echo -e "${turquesa}6: Onedriver ${endColour}"
    echo -e "${turquesa}7: VisualStudio ${endColour}"
    echo -e "${turquesa}8: Gparted ${endColour}"
    echo -e "${turquesa}9: Plank ${endColour}"
    echo -e "${turquesa}10: Temas ${endColour}"
    echo -e "${turquesa}11: Stacer ${endColour}"
    echo -e "${turquesa}12: Webmin ${endColour}"
    echo -e "${turquesa}13: Synaptic ${endColour}"
    echo "---------------------------"
    echo -e "${amarillo} SERVIDORES ${endColour}"
    echo "---------------------------"
    echo -e "${turquesa}a: Servidor Samba ${endColour}"
    echo -e "${turquesa}b: Servidor NOIP ${endColour}"
    echo -e "${turquesa}c: Servidor RAID ${endColour}"
    echo -e "${turquesa}x: Servidor xxx ${endColour}"
    echo ""
	echo -e "${turquesa}0: Salir ${endColour}"
    echo ""
	echo "-----------------------------"
    echo -e "${verde}Por favor, ingrese su operación ${endColour}"
    read a

    while [ $a != "0" ] && 
    [ $a != "1" ] && 
    [ $a != "2" ] && 
    [ $a != "3" ] && 
    [ $a != "4" ] && 
    [ $a != "5" ] && 
    [ $a != "6" ] && 
    [ $a != "7" ] && 
    [ $a != "8" ] && 
    [ $a != "9" ] && 
    [ $a != "10" ] && 
    [ $a != "11" ] && 
    [ $a != "12" ] &&
    [ $a != "13" ] &&
    [ $a != "a" ] &&
    [ $a != "b" ] &&
    [ $a != "c" ]

    do
        echo -e "${rojo}Entrada incorrecta, por favor vuelva a ingresar una opcion ${endColour}"
		read a
    done
	
	case "$a" in 
	0)
        Salir;;
	1)
        Tilix
        instalacion;;
    2)
        Sublime
        instalacion;;
    3)
        docker
        instalacion;;
    4)
        Veracrypt
        instalacion;;
    5)
        VNC
        instalacion;;
    6)
        Onedriver
        instalacion;;
    7)
        VisualStudio
        intalacion;;
    8)
        Gparted
        instalacion;;
    9)
        Plank
        instalacion;;
    10)
        temas
        instalacion;;
    11)
        Stacer
        instalacion;;
    12)
        Webmin
        instalacion;;
    13)
        synaptic
        instalacion;;
    a)
        samba
        instalacion;;
    b)
        NOIP
        instalacion;;
    c)
        RAID
        instalacion;;
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

#########################

login
echo -e "${turquesa}Actualizando el sistema... ${endColour}"
echo $cont | sudo -S apt update -y > /dev/null 2>&1
sudo apt upgrade -y > /dev/null 2>&1 
terminal
actualizarlimpiar
clear

echo -e "${turquesa}Estas en una VM VirtualBox? (s/n) ${endColour}"
read vm
if [ $vm == "s" ];
then
    VM
fi

clear
echo -e "${turquesa}Quieres instalar mas programas? (s/n) ${endColour}"
read s

if [ $s == "s" ];
then
    instalacion
fi

if [ $s == "n" ];
then
    echo -e "${rojo}Deberias reiniciar ${endColour}"
    Salir
fi