#!/bin/bash

#COPIA DE SEGURIDAD

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
    kernel.panic = 10'> ~/sysctl.conf

    sudo cp ~/sysctl.conf /etc/sysctl.conf
    sudo rm -R ~/sysctl.conf
}

function UFW ()
{
    sudo dpkg -l | grep -i "ufw" > /dev/null 2>&1
    if [ "$(echo $?)" == "1" ];
    then
        sudo apt install ufw -y > /dev/null 2>&1
        sudo ufw default allow incoming
        sudo ufw enable
        sudo ufw default allow incoming
    else
        sudo ufw default allow incoming
        sudo ufw enable
        sudo ufw default allow incoming
    fi
}

BastionadoSSH > /dev/null 2>&1
BastionadoCTL > /dev/null 2>&1
UFW > /dev/null 2>&1

sudo truncate -s0 /etc/resolv.conf > /dev/null 2>&1
echo "nameserver 1.1.1.1" | sudo tee -a /etc/resolv.conf > /dev/null 2>&1
echo "nameserver 1.0.0.1" | sudo tee -a /etc/resolv.conf > /dev/null 2>&1

sudo sysctl -p > /dev/null 2>&1
sudo update-grub2 > /dev/null 2>&1
sudo systemctl restart systemd-timesyncd
sudo ufw --force enable
sudo service ssh restart