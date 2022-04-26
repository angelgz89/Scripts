#! /bin/bash


sudo apt install ufw -y > /dev/null 2>&1
sudo ufw enable
sudo ufw default allow incoming

