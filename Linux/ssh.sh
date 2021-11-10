#!/bin/bash

clear

if [ $(uname) == "Linux" ];
then
    sudo dpkg -l | grep -i "sshpass" > /dev/null 2>&1
    if [ "$(echo $?)" == "1" ]
    then
        sudo apt install sshpass -y > /dev/null 2>&1
        echo "SSHPASS INSTALADO"
    fi
fi

if [ $(uname) == "Darwin" ];
then
    brew install hudochenkov/sshpass/sshpass
fi

clear
echo "Servidor SSH?"
read servidor

clear
echo "Usuario SSH?"
read usuario

clear
echo "Contraseña del servidor SSH?"
read contrasenia

clear
echo "Puerto SSH?"
read puerto

clear
echo "Home del servidor SSH?"
read home

clear
echo "Has creado la clave pub? (s/n)"
read a

if [ $a == "n" ];
then
    ssh-keygen -t rsa -b 4096
fi

sshpass -p $contrasenia scp ~/.ssh/id_rsa.pub $usuario@$servidor:

sshpass -p $contrasenia ssh -t $usuario@$servidor bash -c "'
cat ~/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
rm -R ~/id_rsa.pub
'"

clear
echo "Quieres conectarte al servidor SSH? (s/n)"
read a

if [ $a == "s" ];
then
    sshpass -p $contrasenia ssh -t $usuario@$servidor
else
    echo "Adios"
fi
