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
    # --quiet
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
    export PATH="$PATH:$HOME/Scripts/Linux"' > ~/.zshrc

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

function BastionadoSSH ()
{
    echo "BASTIONADO SSH"
    sudo cp -r -f /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
    sudo cp -r -f /etc/ssh/sshd_config ~/sshd_config.bak

    touch ~/sshd_config
    echo '
    Include /etc/ssh/sshd_config.d/*.conf

    AcceptEnv LANG LC_*

    # Puerto
    Port 22

    # Usuarios
    PermitRootLogin no

    # Contraseña o Clave publica
    PasswordAuthentication yes
    PermitEmptyPasswords no
    #AuthenticationMethods publickey
    #PubkeyAuthentication yes

    # Depending on your 2FA option, you may need to enable some of these options, but they should be disabled by default
    ChallengeResponseAuthentication no

    # Disable connection multiplexing which can be used to bypass authentication
    MaxSessions 2

    # Bloquear clientes 30 minutos despues de fallar 2 intentos de login
    MaxAuthTries 2
    LoginGraceTime 30

    # Enable PAM authentication
    UsePAM yes

    # Disable Kerberos based authentication
    KerberosAuthentication no
    KerberosGetAFSToken no
    KerberosOrLocalPasswd no
    KerberosTicketCleanup yes
    GSSAPIAuthentication no
    GSSAPICleanupCredentials yes

    # Disable user environment forwarding
    X11Forwarding no
    AllowTcpForwarding no
    AllowAgentForwarding no
    PermitUserRC no
    PermitUserEnvironment no

    # We want to log all activity
    LogLevel INFO
    SyslogFacility AUTHPRIV

    # What messages do you want to present your users when they log in?
    Banner none
    PrintMotd no
    PrintLastLog yes

    #Evitar zombies
    TCPKeepAlive no
    ' > ~/sshd_config

    read -p "Quieres cambiar el puerto por defecto? [Y/n]" -n 1 portChange
    printf "\n"
    if [[ $portChange =~ ^[Yy]$ ]];then
    read -p "Introcude el puerto nuevo: " portNum
    sed -i "s/.*Port.*/Port $portNum/g" ~/sshd_config
    fi

    read -p "Quieres habilitar el acceso root? [Y/n]" -n 1 rootLogin
    printf "\n"
    if [[ $rootLogin =~ ^[Yy]$ ]];then
        sed -i "s/.*PermitRootLogin.*/PermitRootLogin yes/g" ~/sshd_config
    fi

    read -p "Quieres deshabilitar el acceso por contraseña? [Y/n]" -n 1 rootLogin
    printf "\n"
    if [[ $rootLogin =~ ^[Yy]$ ]];then
        sed -i "s/.*PasswordAuthentication.*/PasswordAuthentication no/g" ~/sshd_config
    fi

    read -p "Quieres permitir el acceso con contraseña vacia? [Y/n]" -n 1 emptyPass
    printf "\n"
    if [[ $emptyPass =~ ^[Yy]$ ]];then
    sed -i "s/.*PermitEmptyPasswords.*/PermitEmptyPasswords yes/g" ~/sshd_config
    fi

    read -p "Quieres permitir el acceso con clave publica? [Y/n]" -n 1 emptyPass
    printf "\n"
    if [[ $emptyPass =~ ^[Yy]$ ]];then
        sed -i "s/.*AuthenticationMethods.*/AuthenticationMethods publickey/g" ~/sshd_config
        sed -i "s/.*PubkeyAuthentication.*/PubkeyAuthentication yes/g" ~/sshd_config
    fi


    read -p "Quieres habilitar TCPKeepAlive para evitar los zombis?[Y/n]" -n 1 zombies
    printf "\n"
    if [[ $zombies =~ ^[Yy]$ ]];then
        sed -i "s/.*TCPKeepAlive.*/TCPKeepAlive yes/g" ~/sshd_config
    fi

    sudo cp ~/sshd_config /etc/ssh/sshd_config
    sudo rm -R ~/sshd_config

    sudo service ssh restart
}

function BastionadoCTL () 
{
    echo "BASTIONADO CTL"
    #COPIA DE SEGURIDAD
    sudo cp -r -f /etc/sysctl.conf /etc/sysctl.conf.bak
    sudo cp -r -f /etc/sysctl.conf ~/sysctl.conf.bak

    touch ~/sysctl.conf
    echo '
    # IP Spoofing protection
    net.ipv4.conf.all.rp_filter = 1
    net.ipv4.conf.default.rp_filter = 1

    # Ignore ICMP broadcast requests
    net.ipv4.icmp_echo_ignore_broadcasts = 1

    # Disable source packet routing
    net.ipv4.conf.all.accept_source_route = 0
    net.ipv6.conf.all.accept_source_route = 0 
    net.ipv4.conf.default.accept_source_route = 0
    net.ipv6.conf.default.accept_source_route = 0

    # Ignore send redirects
    net.ipv4.conf.all.send_redirects = 0
    net.ipv4.conf.default.send_redirects = 0

    # Block SYN attacks
    net.ipv4.tcp_syncookies = 1
    net.ipv4.tcp_max_syn_backlog = 2048
    net.ipv4.tcp_synack_retries = 2
    net.ipv4.tcp_syn_retries = 5

    # Log Martians
    net.ipv4.conf.all.log_martians = 1
    net.ipv4.icmp_ignore_bogus_error_responses = 1

    # Ignore ICMP redirects
    net.ipv4.conf.all.accept_redirects = 0
    net.ipv6.conf.all.accept_redirects = 0
    net.ipv4.conf.default.accept_redirects = 0 
    net.ipv6.conf.default.accept_redirects = 0

    # Ignore Directed pings
    net.ipv4.icmp_echo_ignore_all = 1

    # Disable IPv6
    net.ipv6.conf.all.disable_ipv6 = 1
    net.ipv6.conf.default.disable_ipv6 = 1
    net.ipv6.conf.lo.disable_ipv6 = 1

    # Hide kernel pointers
    kernel.kptr_restrict = 2

    # Enable panic on OOM
    vm.panic_on_oom = 1

    # Reboot kernel ten seconds after OOM
    kernel.panic = 10
    '> ~/sysctl.conf

    sudo cp ~/sysctl.conf /etc/sysctl.conf
    sudo rm -R ~/sysctl.conf
}

function UFW ()
{
    sudo dpkg -l | grep -i "ufw" > /dev/null 2>&1
    if [ "$(echo $?)" == "1" ];
    then
        sudo apt install ufw -y > /dev/null 2>&1
        sudo ufw default allow incoming > /dev/null 2>&1
        sudo ufw enable > /dev/null 2>&1
        sudo ufw default allow incoming > /dev/null 2>&1
    else
        sudo ufw default allow incoming > /dev/null 2>&1
        sudo ufw enable > /dev/null 2>&1
        sudo ufw default allow incoming > /dev/null 2>&1
    fi
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

BastionadoSSH
BastionadoCTL
UFW

sudo truncate -s0 /etc/resolv.conf > /dev/null 2>&1
echo "nameserver 1.1.1.1" | sudo tee -a /etc/resolv.conf > /dev/null 2>&1
echo "nameserver 1.0.0.1" | sudo tee -a /etc/resolv.conf > /dev/null 2>&1

sudo sysctl -p > /dev/null 2>&1
sudo update-grub2 > /dev/null 2>&1
sudo systemctl restart systemd-timesyncd
sudo ufw --force enable
sudo service ssh restart

actualizarlimpiar
sudo reboot