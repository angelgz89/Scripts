#!/bin/bash

#COPIA DE SEGURIDAD
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