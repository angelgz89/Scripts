#!/bin/bash

echo "***** MEMORIA UTILIZADA Y LIBRE *****"
free
echo ""

echo "***** SISTEMA EN TIEMPO Y CARGA *****"
uptime
echo ""

echo "***** USUARIOS ACTUALMENTE REGISTRADOS *****"
who
echo ""

echo "***** TOP 5 PROCESOS DE CONSUMO DE MEMORIA *****"
ps -eo %mem,%cpu,comm --sort=-%mem | head -n 6
echo ""
