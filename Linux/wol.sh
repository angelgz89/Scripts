#! /bin/bash

echo "Quieres despertar PC? (s/n))"
read d

if [ $d = "s" ];
then
        wakeonlan 3C:7C:3F:DA:4C:0D
fi

echo "Quieres despertar Server? (s/n))"
read c

if [ $c = "s" ];
then
	wakeonlan 3C:7C:3F:C1:82:CA
fi

echo "Quieres despertar MiniServer? (s/n))"
read b

if [ $b = "s" ];
then
	#wakeonlan -i 192.168.1.111 -p 9 1C:83:41:28:1C:6E
	wakeonlan 1C:83:41:28:1C:6E
fi

echo "Quieres despertar MicroServer? (s/n))"
read c

if [ $c = "s" ];
then
	wakeonlan 84:47:09:0F:E1:58
fi

# echo "Quieres despertar Macro server? (s/n))"
# read a

# if [ $a = "s" ];
# then
# 	wakeonlan FC:34:97:66:DE:0E
# fi




