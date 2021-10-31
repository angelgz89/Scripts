#!/bin/bash

clear

if [ $(uname) == "linux" ];
then
    sudo apt-get install sshpass
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
    ssh-keygen -t rsa -b 4096 /dev/null 2>&1
fi

sshpass -p $contrasenia scp -P$puerto $HOME/.ssh/id_rsa.pub $usuario@$servidor:

sshpass -p $contrasenia ssh -t -p$puerto $usuario@$servidor bash -c "'
echo prueba
cat $home/id_rsa.pub >> /home/angel/.ssh/authorized_keys
chmod 600 $home/.ssh/authorized_keys
'"

clear
echo "Quieres conectarte al servidor SSH? (s/n)"
read a

if [ $a == "s" ];
then
    sshpass -p $contrasenia ssh -t -p$puerto $usuario@$servidor
else
    echo "Adios"
fi
