#! /bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: M4h0uT

echo interfaz?
read interfaz

echo "Por favor, introduce la contraseña de administrador para usar el programa:"
read -s cont

echo $cont | sudo -s apt update -y
echo $cont | sudo -s apt install ethtool -y
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

sudo systemctl daemon-reload
sudo systemctl enable wol.service
sudo systemctl start wol.service