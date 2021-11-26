#! /bin/bash

sudo ufw status | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | wc -l
