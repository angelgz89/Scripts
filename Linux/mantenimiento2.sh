#!/bin/bash

function main
{
	clear
	echo "---------------------------"
	echo -e "\033[33;1mScript de mantenimiento del administrador del sistema \033[0m"
	echo "---------------------------"

	read -p "Pulse cualquier tecla para continuar" a
	#read -s a

	case "$a" in *)
		Menu;;
	esac
}
 
 
function Menu
{
	clear
	echo "---------------------------"
	echo -e "\033[33;1mScript de mantenimiento del administrador del sistema \033[0m"
	echo "---------------------------"
	echo -e "\033[31;1m 0: Salir del sistema \033[0m"
	echo -e "\033[31;1m 1: Módulo de secuencia de comandos de gestión de disco de usuario \033[0m"
	echo -e "\033[31;1m 2: Módulo de gestión de archivos de directorio \033[0m"
	echo -e "\033[31;1m 3: módulo de gestión de archivos C ++ \033[0m"
	echo -e "\033[31;1m 4: módulo de secuencia de comandos de gestión de terminal \033[0m"
	echo -e "\033[31;1m 5: módulo de gestión de servicios de red \033[0m"
	echo "-----------------------------"
    echo "Por favor ingrese su operación" 
    read a
	
	
	case "$a" in 
	0)
		return 0;;
	1)
		CiPan;;
	2)
		MuLu;;
	3)
		CFile;;
	4)	
		ZhonD;;
	5)
		Net;;
	*)
		echo -e "\033[31;1mEntrada incorrecta, por favor vuelva a ingresar una opcion \033[0m"
		read b

		case "$b" in *)
			Menu;;
		esac
	esac
}

 # Estadísticas de la ocupación de disco de cada usuario en el sistema, e imprima el nombre del usuario que ocupa el mayor espacio en disco;
function CiPan
{
	clear
	echo "------------------------------------------"
	echo -e "\033[33;1m La ocupación del disco de cada usuario es la siguiente: \033[0m"
	df -a $HOME

	echo -e "\033[33;1m El nombre de usuario que ocupa el mayor espacio en disco: \033[0m"
	df -a $HOME| sort -n -r| head -n 1

	echo "-------------------------------------------"
	echo -e "\033[31;1m Pulse cualquier tecla para continuar >>> \033[0m"
	echo "-----------------------------------------"
	read a

	case "$a" in *)
		Menu;;
	esac
	
}

 # Recorra y busque el archivo más grande en el directorio de usuarios e imprima el nombre del archivo y su número de bytes
function MuLu
{
	clear
	 echo -e "\ 033 [33; 1m El archivo más grande e información relacionada en el directorio de inicio: \ 033 [0m"
	du -a $HOME -h|sort -n -r| head -n 1
	 echo -e "\ 033 [31; 1m Pulse cualquier tecla para continuar >>> \ 033 [0m"
	echo -e "-----------------------------------------"
	read a
	case "$a" in *)
		Menu;;
	esac
}
 # Consulte todos los programas fuente de C ++ (incluidos * .cpp, * .h) en el directorio de usuario especificado y cuente el número total de líneas de código
function CFile
{
	clear
	 echo -e "\ 033 [33; 1m El número total de líneas de código del programa fuente C ++ en el directorio de inicio \ 033 [0m"
	find $HOME -name "*.cpp" -o -name "*.h"|xargs grep '^.' |wc -l
	 echo -e "\ 033 [31; 1m Pulse cualquier tecla para continuar >>> \ 033 [0m"
	echo -e "-----------------------------------------"
	read a
	case "$a" in *)
		Menu;;
	esac
	
}
 
 
 # Consultar si un usuario está en línea e imprimir el número de terminales en línea
function ZhonD
{
	clear
	 echo -e "\ 033 [33; 1m Por favor ingrese el nombre de usuario que desea consultar: \ 033 [0m"
	read b
	who -q >$HOME/get.txt
	 echo -e "\ 033 [38; 1m Los siguientes archivos son el contenido de todos los usuarios conectados en línea \ 033 [0m"
	cat $HOME/get.txt
	 echo -e "\ 033 [38; 1m El número de terminales es: \ 033 [0m"
	who | wc -l 
	 echo -e "\ 033 [31; 1m Pulse cualquier tecla para continuar >>> \ 033 [0m"
	echo -e "-----------------------------------------"
	read a
	case "$a" in *)
		Menu;;
	esac
}
 # Consulta, abre y cierra FTP, servicio de red Apache
function Net
{
	clear
	echo "---------------------------"
	 echo -e "\ 033 [33; 1m gestión de servicios de red \ 033 [0m"
	echo 
	 echo -e "\ 033 [31; 1m 0. Vuelve a la interfaz principal \ 033 [0m"
	 echo -e "\ 033 [31; 1m 1. Consultar servicio FTP \ 033 [0m"
	 echo -e "\ 033 [31; 1m 2. Consultar servicio Apache \ 033 [0m"
	 echo -e "\ 033 [31; 1m 3. Abra el servicio FTP \ 033 [0m"
	 echo -e "\ 033 [31; 1m 4. Abra el servicio Apache \ 033 [0m"
	 echo -e "\ 033 [31; 1m 5. Desactive el servicio FTP \ 033 [0m"
	 echo -e "\ 033 [31; 1m 6. Cierre el servicio Apache \ 033 [0m"
	 echo -e "\ 033 [31; 1m Por favor elija su operación >>> \ 033 [0m"
	echo "-------------------------------"
	read  -p ">>>>>>" a
	case "$a" in
	0)
		Menu;;
	1)
		ftp ?;;
	2)
		cat ./etc/init.d/apache2;;
	3)
		ftp open;;
	4)
		./etc/init.d/apache2 restart;;
	5)
		ftp close;;
	6)
		./etc/init.d/apache2 stop;;
	*)	
		 echo -e "\ 033 [31; 1m entrada incorrecta, por favor vuelva a ingresar >>> \ 033 [0m"
		read -p ">>>>>>>" b
		case "$b" in
		*)
			Net;;
		esac
	esac
}
 
main