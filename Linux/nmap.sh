#!/bin/bash

sudo nmap -sV --script=default,vuln -T5 -vvv -n 192.168.1.111