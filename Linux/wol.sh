#! /bin/bash

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

echo "Quieres despertar MiniMacroServer? (s/n))"
read c

if [ $c = "s" ];
then
	wakeonlan 18:C0:4D:D1:F8:96
fi