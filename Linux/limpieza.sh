#!/bin/bash

echo -e "\e[31;43m ***** INFORMACIÓN DEL HOSTNAME ***** \e[0m"
hostnamectl
echo ""

# -El uso del espacio en disco del sistema de archivos:
echo -e "\e[31;43m ***** SISTEMA DE ARCHIVO DISCO ESPACIO UTILIZADO ***** \e[0m"
df -h
echo ""

# - Memoria libre y usada en el sistema:
echo -e "\e[31;43m ***** MEMORIA UTILIZADA Y LIBRE ***** \e[0m"
free
echo ""

# -Sistema de tiempo de actividad y carga:
echo -e "\e[31;43m ***** SISTEMA EN TIEMPO Y CARGA ***** \e[0m"
uptime
echo ""

# -Usuarios Conectados:
echo -e "\e[31;43m ***** USUARIOS ACTUALMENTE REGISTRADOS ***** \e[0m"
who
echo ""

# -Top 5 procesa en lo que respecta al uso de memoria
echo -e "\e[31;43m ***** TOP 5 PROCESOS DE CONSUMO DE MEMORIA ***** \e[0m"
ps -eo %mem,%cpu,comm --sort=-%mem | head -n 6
echo ""

echo -e "\e[31;43m ***** SERVICIOS CORRIENDO ACTUALMENTE ***** \e[0m"
service --status-all | grep "+"
echo ""

echo -e "\e[1;32m Hecho. \e[0m"