
        #!/bin/bash
        cpuTemp=$(cat /sys/class/thermal/thermal_zone0/temp)
        #gpuTemp=$(vcgencmd measure_temp)
        echo "Temperatura CPU = $((cpuTemp/1000))ºC"
