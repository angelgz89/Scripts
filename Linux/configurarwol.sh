#! /bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: M4h0uT

echo interfaz?
read interfaz

echo "Por favor, introduce la contraseña de administrador para usar el programa:"
read -s cont

echo $cont | sudo -S apt update -y
sudo apt install ethtool -y
sudo ethtool -s $interfaz wol g
sudo apt install wakeonlan -y

touch wol.service

echo '[Unit]
Description=Configure Wake On LAN

[Service]
Type=oneshot
ExecStart=/sbin/ethtool -s '$interfaz' wol g

[Install]
WantedBy=basic.target' >> wol.service

sudo cp wol.service /etc/systemd/system/

rm -R wol.service

sudo systemctl daemon-reload
sudo systemctl enable wol.service
sudo systemctl start wol.service