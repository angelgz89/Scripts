#! /bin/bash

sudo cat /var/log/auth.log | grep -a "Accepted" | awk '{print $1 " " $2 "\t" $3 "\t" $11 "\t" $9 }'
