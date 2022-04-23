#!/bin/bash

#Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AZUL="\e[0;34m\033[1m"
AMARILLO="\e[0;33m\033[1m"
VIOLETA="\e[0;35m\033[1m"
CYAN="\e[0;36m\033[1m"
GRIS="\e[0;37m\033[1m"
NEGRO="\e[0;30m\033[1m"
endColour="\033[0m\e[0m"

#############################################################################################

function login ()
{
    clear
    echo -e "${VIOLETA}Por favor, introduce la contraseña de administrador: ${endColour}"
    read -s cont
    clear
    echo $cont | sudo -S -v > /dev/null 2>&1

    #MAQUINA VIRTUAL
    sudo dmesg | grep VirtualBox > /dev/null 2>&1
    if [ "$(echo $?)" == "0" ];
    then
        sudo dpkg -l | grep -i "virtualbox-guest-x11" > /dev/null 2>&1
        if [ "$(echo $?)" == "1" ];
        then
            sudo apt install virtualbox-guest-dkms virtualbox-guest-x11 -y > /dev/null 2>&1
            sudo apt-get install build-essential gcc make perl dkms -y > /dev/null 2>&1
            echo -e "${AMARILLO}[*]${endColour}${VERDE} Guest Additions Instaladas${endColour}"
        fi
    fi
}

function limpieza () 
{
    sudo apt remove --purge -y onboard mousepad gnome-font-viewer gucharmap info libreoffice-common libreoffice-base-core xfburn atril xfce4-dict xfce4-taskmanager pidgin xfce4-screenshooter thunderbird catfish gnome-sudoku gnome-mines sgt-launcher ristretto gimp simple-scan > /dev/null 2>&1
    sudo add-apt-repository ppa:xubuntu-dev/staging -y > /dev/null 2>&1
}

function actualizarlimpiar ()
{
	echo -e "${CYAN}Actualizando el sistema... ${endColour}"
	sudo apt update -y > /dev/null 2>&1
	sudo apt full-upgrade -y > /dev/null 2>&1
	sudo apt update -y > /dev/null 2>&1
    apt-get autoremove -y > /dev/null 2>&1
    apt-get autoclean -y > /dev/null 2>&1
	sudo apt --fix-broken install -y > /dev/null 2>&1
    sudo apt update -y > /dev/null 2>&1
    # find /var/log -type f -delete > /dev/null 2>&1
    # rm -rf /usr/share/man/* > /dev/null 2>&1

    # rm -rf ~/.local/share/Trash/*
    # sudo rm -rf /tmp/*
    # sudo rm -vfr /tmp/* >/dev/null 2>&1
    # rm -vfr /var/tmp/* >/dev/null 2>&1
	# sudo apt unattended-upgrades
	# sudo dpkg-reconfigure --priority=low unattended-upgrades
}

function Basicos () 
{
    sudo apt install openssh-client openssh-server openssh-sftp-server sshpass -y > /dev/null 2>&1

    sudo apt install python3 python3-pip -y > /dev/null 2>&1
    sudo pip3 install gspread > /dev/null 2>&1
	sudo pip3 install selenium > /dev/null 2>&1
	sudo pip3 install oauth2client > /dev/null 2>&1
	sudo pip3 install python-dateutil > /dev/null 2>&1

    #######################################################################################
    sudo dpkg -l | grep -i "git-man" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
        sudo apt install git -y > /dev/null 2>&1
        git config --global user.name angelgz89
        git config --global user.email agz2712@gmail.com
        echo -e "${AMARILLO}[*]${endColour}${VERDE} GIT Instalado ${endColour}"
    else
        git config --global user.name angelgz89
        git config --global user.email agz2712@gmail.com
        echo -e "${AMARILLO}[*]${endColour}${VERDE} GIT ya está instalado ${endColour}"
    fi

    #######################################################################################
    sudo dpkg -l | grep -i "rsync" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
        sudo apt install rsync -y > /dev/null 2>&1
        echo -e "${AMARILLO}[*]${endColour}${VERDE} Rsync Instalado ${endColour}"
    else
        echo -e "${AMARILLO}[*]${endColour}${VERDE} Rsync ya está instalado ${endColour}"
    fi

    #######################################################################################
    sudo dpkg -l | grep -i "wget" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
        sudo apt install wget -y > /dev/null 2>&1
        echo -e "${AMARILLO}[*]${endColour}${VERDE} WGET Instalado ${endColour}"
	else
        echo -e "${AMARILLO}[*]${endColour}${VERDE} WGET ya está instalado ${endColour}"
    fi

    #######################################################################################
    sudo dpkg -l | grep -i "lm-sensors" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
        sudo apt-get install lm-sensors -y > /dev/null 2>&1
        echo -e "${AMARILLO}[*]${endColour}${VERDE} Sensors Instalado ${endColour}"
	else
        echo -e "${AMARILLO}[*]${endColour}${VERDE} Sensors ya está instalado ${endColour}"
    fi

    #######################################################################################
	sudo dpkg -l | grep -i "binutils" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
		sudo apt install binutils -y > /dev/null 2>&1
		echo -e "${AMARILLO}[*]${endColour}${VERDE} Binutils Instalado ${endColour}"
	else
        echo -e "${AMARILLO}[*]${endColour}${VERDE} Binutils ya está instalado ${endColour}"
	fi

    #######################################################################################
	sudo dpkg -l | grep -i "wakeonlan" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
		sudo apt install wakeonlan -y > /dev/null 2>&1
		echo -e "${AMARILLO}[*]${endColour}${VERDE} WakeOnLan Instalado ${endColour}"
	else
        echo -e "${AMARILLO}[*]${endColour}${VERDE} WakeOnLan ya está instalado ${endColour}"
	fi

    #######################################################################################
	sudo dpkg -l | grep -i "chromium-chromedriver" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
		sudo apt install chromium-driver -y > /dev/null 2>&1
		echo -e "${AMARILLO}[*]${endColour}${VERDE} Chronium-driver Instalado ${endColour}"
    else
        echo -e "${AMARILLO}[*]${endColour}${VERDE} Chronium-driver ya está instalado ${endColour}"
	fi

    #######################################################################################
	sudo dpkg -l | grep -i "net-tools" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
		sudo apt install net-tools -y > /dev/null 2>&1
		echo -e "${AMARILLO}[*]${endColour}${VERDE} Net-tools Instalado ${endColour}"
    else
        echo -e "${AMARILLO}[*]${endColour}${VERDE} Net-tools ya está instalado ${endColour}"
	fi
}

function ZSH()
{
    sudo apt install git zsh -y > /dev/null 2>&1
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh > /dev/null 2>&1

    sudo git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions > /dev/null 2>&1
    sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting > /dev/null 2>&1
        
    echo "" > ~/.zshrc
        
    echo '
    export ZSH=$HOME/.oh-my-zsh
    ZSH_THEME="bira"
    plugins=(git
    zsh-autosuggestions
    zsh-syntax-highlighting
    )
    source $ZSH/oh-my-zsh.sh
    export PATH="$PATH:$HOME/Scripts/Linux"' > .zshrc

    #zsh -l
    echo $cont | chsh -s $(which zsh)
    echo ""
    echo -e "${AMARILLO}[*]${endColour}${VERDE} ZSH Instalado${endColour}"
}

function BTOP ()
{
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
    echo -e "${AMARILLO}[*]${endColour}${VERDE} Btop Instalado${endColour}"
}

function Papirus () 
{
    sudo dpkg -l | grep -i "papirus-icon-theme" > /dev/null 2>&1
    if [ "$(echo $?)" == "1" ];
    then
        sudo add-apt-repository ppa:papirus/papirus -y > /dev/null 2>&1
        sudo apt update -y > /dev/null 2>&1
        sudo apt install papirus-icon-theme -y > /dev/null 2>&1
    fi
}

function Tilix () 
{
	sudo dpkg -l | grep -i "tilix" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		sudo apt install -y tilix > /dev/null 2>&1
		echo -e "${AMARILLO}[*]${endColour}${VERDE} Tilix Instalado ${endColour}"
    else
        echo -e "${AMARILLO}[*]${endColour}${VERDE} Tilix ya está instalado ${endColour}"
	fi
}

function Gparted () 
{
	sudo dpkg -l | grep -i "gparted" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		sudo apt install gparted -y > /dev/null 2>&1
		echo -e "${AMARILLO}[*]${endColour}${VERDE} Gparted Instalado ${endColour}"
    else
        echo -e "${AMARILLO}[*]${endColour}${VERDE} Gparted ya está instalado ${endColour}"
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
        echo -e "${AMARILLO}[*]${endColour}${VERDE} Veracrypt Instalado ${endColour}"
    else
        echo -e "${AMARILLO}[*]${endColour}${VERDE} Veracrypt ya está instalado ${endColour}"
    fi
}

function Nomacs () 
{
	sudo dpkg -l | grep -i "nomacs" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		sudo apt install nomacs -y > /dev/null 2>&1
		echo -e "${AMARILLO}[*]${endColour}${VERDE} Nomacs Instalado ${endColour}"
    else
        echo -e "${AMARILLO}[*]${endColour}${VERDE} Nomacs ya está instalado ${endColour}"
	fi
}

function Utilidaddiscos () 
{
	sudo dpkg -l | grep -i "gnome-disk-utility" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ];
	then
		sudo apt install gnome-disk-utility -y > /dev/null 2>&1
		echo -e "${AMARILLO}[*]${endColour}${VERDE} Utilidad de discos Instalada ${endColour}"
    else
        echo -e "${AMARILLO}[*]${endColour}${VERDE} Utilidad de discos ya está instalado ${endColour}"
	fi
}

function Chrome () 
{
    wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
    sudo apt install libappindicator1 -y > /dev/null 2>&1
    dpkg -i ~/google-chrome-stable_current_amd64.deb > /dev/null 2>&1
    echo -e "${AMARILLO}[*]${endColour}${VERDE} Chrome Instalado ${endColour}"
}
    

function BastionadoIP6 ()
{
    sudo cp ./resources/sysctl.conf /etc/sysctl.conf
    sudo cp ./resources/grub /etc/default/grub
    echo -e "${AMARILLO}[*]${endColour}${VERDE} IP6 Bastionado${endColour}"
}

function BastionadoFail2Ban ()
{
    sudo apt install fail2ban -y > /dev/null 2>&1
    # cp ./resources /etc/fail2ban/jail.conf
    sudo systemctl restart fail2ban
    echo -e "${AMARILLO}[*]${endColour}${VERDE} Fail2Ban Bastionado${endColour}"
}

function Gedit ()
{
    sudo dpkg -l | grep -i "gedit" > /dev/null 2>&1
	if [ "$(echo $?)" == "1" ]
	then
        sudo apt install gedit -y > /dev/null 2>&1
    	echo -e "${AMARILLO}[*]${endColour}${VERDE} Gedit Instalado ${endColour}"
	else
        echo -e "${AMARILLO}[*]${endColour}${VERDE} Gedit ya está instalado ${endColour}"
	fi
}

function wakeonlan ()
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



#############################################################################################


login
limpieza
Basicos

#Programas
ZSH
BTOP
Tilix
Gedit
Utilidaddiscos
Nomacs
Veracrypt
Gparted
Chrome

actualizarlimpiar

#Temas
Papirus


#Bastionados
#BastionadoIP6
BastionadoFail2Ban

#Configuracion
wakeonlan

sudo rm -R ~/Documentos
sudo rm -R ~/Imágenes
sudo rm -R ~/Música
sudo rm -R ~/Plantillas
sudo rm -R ~/Público
sudo rm -R ~/Vídeos


actualizarlimpiar