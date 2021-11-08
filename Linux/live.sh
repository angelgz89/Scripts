#!/bin/bash

function muestra_uso 
{
  echo "Introduce 1 argumento"
  echo ""
  echo " 1- IP o dominio del servidor"
  exit 1
}


#Programa principal
if [ $# -ne 1 ] 
then
  muestra_uso
else 
    IP=$1
fi

ping -c 1 $IP > /dev/null 2>&1

#timeout 1 bash -c '"ping -c 1" $IP' &>/dev/null 

if [ "$(echo $?)" == "0" ];
then
  echo "ON"
else
 echo "OFF"
fi
