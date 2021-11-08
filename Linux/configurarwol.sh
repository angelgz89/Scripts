#! /bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: M4h0uT

echo interfaz?
read interfaz

echo "Por favor, introduce la contraseña de administrador para usar el programa:"
read -s cont

echo $cont | sudo apt install ethtool -y
echo $cont | sudo ethtool -s $interfaz wol g
echo $cont | sudo apt install wakeonlan -y

sudo touch /etc/systemd/system/wol.service

sudo echo '
[Unit]
Description=Configure Wake On LAN

[Service]
Type=oneshot
ExecStart=/sbin/ethtool -s $interfaz wol g

[Install]
WantedBy=basic.target
' >> /etc/systemd/system/wol.service

echo $cont | sudo systemctl daemon-reload
echo $cont | sudo systemctl enable wol.service
echo $cont | sudo systemctl start wol.service