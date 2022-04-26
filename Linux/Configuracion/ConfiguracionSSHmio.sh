#!/bin/bash

#COPIA DE SEGURIDAD
sudo cp -r -f /etc/ssh/sshd_config /etc/ssh/sshd_config.bak


read -p "Introduce tu usuario: " usuario
printf "\n"


read -p "Quieres cambiar el puerto por defecto? [Y/n]" -n 1 portChange
printf "\n"
if [[ $portChange =~ ^[Yy]$ ]];
then
  read -p "Introcude el puerto nuevo: " portNum
  printf "\n"
fi

if [[ $portChange =~ ^[Yy]$ ]];
then
  echo "sed \"s/.*Port.*/Port $portNum/\" /etc/ssh/sshd_config > temp" >> .local_script_$0
  echo "cp temp /etc/ssh/sshd_config" >> .local_script_$0
fi


read -p "Do you want to disable root login?[Y/n]" -n 1 rootLogin;printf "\n"
read -p "Do you want to change protocol version to 2?[Y/n]" -n 1 protocolChange;printf "\n"
read -p "Do you want to enable privilege seperation?[Y/n]" -n 1 privilegeSep;printf "\n"
read -p "Do you want to disable empty passwords?[Y/n]" -n 1 emptyPass;printf "\n"
read -p "Do you want to disable X11 forwarding?[Y/n]" -n 1 x11Forwarding;printf "\n"
read -p "Do you want to enable TCPKeepAlive to avoid zombies?[Y/n]" -n 1 zombies;printf "\n"





if [[ $rootLogin =~ ^[Yy]$ ]];then
  echo "sed '0,/^.*PermitRootLogin.*$/s//PermitRootLogin no/' /etc/ssh/sshd_config" >> .local_script_$0

fi
if [[ $protocolChange =~ ^[Yy]$ ]];then
  echo "sed -i \"s/^.*Protocol.*$/Protocol 2/\" /etc/ssh/sshd_config" >> .local_script_$0

fi
if [[ $privilegeSep =~ ^[Yy]$ ]];then
  echo "sed -i \"s/^.*UsePrivilegeSeparation.*$/UsePrivilegeSeparation yes/\" /etc/ssh/sshd_config" >> .local_script_$0

fi
if [[ $emptyPass =~ ^[Yy]$ ]];then
  echo "sed -i \"s/^.*PermitEmptyPasswords.*$/PermitEmptyPasswords no/\" /etc/ssh/sshd_config" >> .local_script_$0

fi
if [[ $x11Forwarding =~ ^[Yy]$ ]];then
  echo "sed -i \"s/^.*X11Forwarding.*$/X11Forwarding no/\" /etc/ssh/sshd_config" >> .local_script_$0

fi
if [[ $zombies =~ ^[Yy]$ ]];then
  echo "sed -i \"s/^.*TCPKeepAlive.*$/TCPKeepAlive yes/\" /etc/ssh/sshd_config" >> .local_script_$0

fi
