#! /bin/bash

#sudo ufw enable
#sudo ufw default allow incoming

sudo cat /var/log/auth.log | grep -a "Failed password" | awk '{print $11}' | un>
sudo cat /var/log/auth.log | grep -a "Failed" | awk '{print $13}' | uniq -c | s>
sudo cat /var/log/auth.log | grep -a "Did not" | awk '{print $12}' | uniq -c | >

for ip in $(cat ipsbloqueadas.txt);
do
    echo "$ip"
    sudo ufw deny from $ip port 22 > /dev/null 2>&1
done

cat ipsbloqueadas.txt | uniq >> IPbloqueadas.txt
rm ipsbloqueadas.txt
