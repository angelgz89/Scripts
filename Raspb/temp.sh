
#!/bin/bash

# Guardamos el valor de temperatura de la CPU a una variable
cpuTemp=$(cat /sys/class/thermal/thermal_zone0/temp)

# Guardamos el valor de temperatura de la GPU a una variable
gpuTemp=$(vcgencmd measure_temp)

# Imprimimos con el formato que queramos. Incluimos la fecha
echo "Temperatura CPU = $((cpuTemp/1000))ºC"
