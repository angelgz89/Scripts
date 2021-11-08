
#! /bin/bash
# -*- ENCODING: UTF-8 -*-
# Author: M4h0uT

# sshpass -p 12AP3Nagz! ssh -t angel@angelgz89.ddns.net zsh -c "'
# echo $cls
# #echo "Temperatura"
# /home/angel/MisDocumentos/Scripts/Linux/temperatura.sh
# # > /dev/null 2>&1
# # python3 ~/MisDocumentos/Servidores/InversionGdrive.py
# '"

#sshpass -p 12AP3Nagz! ssh -t angel@angelgz89.ddns.net zsh -c "'
#echo prueba
#sshpass -p 12AP3Nagz! ssh angel@192.168.1.101
#'"

function menu ()
{
    echo "1: MacroServer "
    echo "2: MiniPc "
    echo "3:  "
    echo "4:  "
    echo "5:  "
    echo ""
    echo "0: Volver al Menu principal"
    echo ""
    echo "-----------------------------"
    echo "Por favor, ingrese su operación"
    read a
	
    while [ $a != "0" ] && [ $a != "1" ] && [ $a != "2" ] && [ $a != "3" ] && [ $a != "4" ] && [ $a != "5" ]
    do
        echo "Entrada incorrecta, por favor vuelva a ingresar una opcion"
		read a
    done
	
	case "$a" in 
	0)
        clear;;
	1)
        sshpass -p 12AP3Nagz! ssh angel@angelgz89.ddns.net;;
	2)
        sshpass -p 12AP3Nagz! ssh angel@192.168.1.111;;
	3)
        menu;;
	4)	
        menu;;
	5)
        menu;;
	esac
}

menu