#! /bin/bash

#sudo ufw enable
#sudo ufw default allow incoming

sudo cat /var/log/auth.log | grep -a "Failed password" | awk '{print $11}' | uniq -c | sort -nr | awk '{print $2}' | grep -E '\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?(\.|$)){4}\b' | uniq > ipsbloqueadas.txt

for ip in $(cat ipsbloqueadas.txt);
do
    echo "$ip"
    sudo ufw deny from $ip > /dev/null 2>&1
done

rm ipsbloqueadas.txt
