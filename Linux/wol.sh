#!/bin/bash

#sudo apt install ethtool -y
#sudo ethtool -s INTERFACE wol g

echo "Quieres despertar Macro server? 1"
read a

if [ $a = "1" ];
then
	wakeonlan -i 192.168.1.101 -p 9 FC:34:97:66:DE:0E
fi
