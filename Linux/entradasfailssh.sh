#! /bin/bash

sudo cat /var/log/auth* | grep -a "Failed password" | awk '{print $11}' | uniq -c | sort -nr | awk '{print $2}' | grep -E '\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?(\.|$)){4}\b' | uniq
