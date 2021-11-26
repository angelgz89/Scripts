#! /bin/bash


if [ -d "~/Descargas" ]
then
    cd ~/Descargas
    if [ -d "~/Descargas/lynis" ]
    then
        cd ~/Descargas/lynis
        sudo ./lynis audit system  
    else
        wget https://downloads.cisofy.com/lynis/lynis-3.0.6.tar.gz
        tar xzvf lynis-3.0.6.tar.gz
        rm -R lynis-3.0.6.tar.gz
        cd ~/Descargas/lynis
        sudo ./lynis audit system  
   fi
else
    mkdir ~/Descargas
    cd ~/Descargas
    wget https://downloads.cisofy.com/lynis/lynis-3.0.6.tar.gz
    tar xzvf lynis-3.0.6.tar.gz
    rm -R lynis-3.0.6.tar.gz
    cd ~/Descargas/lynis
    sudo ./lynis audit system  
fi