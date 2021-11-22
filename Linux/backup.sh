#!/bin/bash

function muestra_uso 
{
  echo "Introduce 1 argumento"
  echo ""
  echo " 1- IP o dominio del servidor"
  exit 1
}

usuario="angel"
contrasenia="12AP3Nagz!"
MINIPC="1C:83:41:28:1C:6E"
MACROSERVER="FC:34:97:66:DE:0E"
MINIMACROSERVER="3C:7C:3F:C1:82:CA"

#Programa principal
if [ $# -ne 1 ] 
then
  muestra_uso
else 
    IP=$1
fi

if [ $IP = "192.168.1.200" ];
then
    wakeonlan $MACROSERVER
fi

if [ $IP = "192.168.1.155" ];
then
    wakeonlan $MINIMACROSERVER
fi

if [ $IP = "192.168.1.111" ];
then
    wakeonlan $MINIPC
fi

ping -c 1 $IP > /dev/null 2>&1 
while [ "$(echo $?)" == "1" ]
do
    ping -c 1 $IP > /dev/null 2>&1
done

sshpass -p $contrasenia scp ~/prueba.txt $usuario@$IP:

sshpass -p $contrasenia ssh -t $usuario@$IP bash -c "'
echo "12AP3Nagz!" | sudo -S shutdown -h 0'"

