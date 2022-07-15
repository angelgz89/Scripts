#! /bin/bash

sudo cat /var/log/auth.log | grep -a "Failed password" | awk '{print $11}' | uniq -c | sort -nr | awk '{print $2}' | grep -E '\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?(\.|$)){4}\b' | uniq
sudo cat /var/log/auth.log | grep -a "Failed" | awk '{print $13}' | uniq -c | sort -nr | awk '{print $2}' | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}"
sudo cat /var/log/auth.log | grep -a "Did not" | awk '{print $12}' | uniq -c | sort -nr | awk '{print $2}' | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}"
