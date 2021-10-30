#
# Script: Limpiar archivo tmp
# Descripcion: Script para borrar los archivos temporales del sistema.
# Version: 0.01
#
#!/bin/bash

DATA=""
DIR="/home"
HELP=""
function remove_temps {
if [ -d "$DIR" ]; then
DATA=$(find $DIR -iname '*.*~*' -printf '%p')
rm $DATA
echo -e "\nTemp files has been removed\t\t[ok]\n"
else
echo -e "\nERROR: Directory do not exist or not been correctly specified? (use -h (| ?help) for help)\n"
fi
}
while [ "$1" != "" ]; do
case $1 in
-d | ?dir ) shift
DIR=$1
;;
-h | ?help ) shift
HELP="OK"
;;
* ) echo "ERROR: Unrecognized Option. (use -h (| ?help) for help)"
exit
esac
shift
done
if [ "$HELP" != "OK" ]; then
remove_temps $DIR
else
echo -e "\n---------------------------------------"
echo "Remove tmp files (like .??~) (v0.04) By Warptrosse"
echo "---------------------------------------"
echo -e "\nTo remove tmp files use clear_tmp_files -d (| -dir) \n"
fi

echo "Ejecutando analisis de virus, por favor espere"
sudo clamscan -r /
echo "Analisis finalizado"
echo "Iniciando desfragmentación del disco, no ejecute ninguna acción hasta que termine la operacion"
e4defrag /

