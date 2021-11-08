#! /bin/bash

#sudo apt install ethtool -y
#sudo ethtool -s INTERFACE wol g

echo "Quieres despertar Macro server? (s/n))"
read a

if [ $a = "s" ];
then
	wakeonlan -i 192.168.1.101 -p 9 FC:34:97:66:DE:0E
fi

echo "Quieres despertar MiniPc? (s/n))"
read b

if [ $b = "s" ];
then
	#wakeonlan -i 192.168.1.111 -p 9 1C:83:41:28:1C:6E
	wakeonlan 1C:83:41:28:1C:6E
fi