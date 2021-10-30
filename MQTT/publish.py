import paho.mqtt.client as mqtt
#sudo pip3 install paho-mqtt
from time import sleep
import os

broker_address = "192.168.1.111"
user = "Servidor"
topic = "prueba1"

client = mqtt.Client(user)
client.connect(broker_address)

while True:
    temperaturapi=float(os.popen('cat /sys/class/thermal/thermal_zone0/temp').read())/1000
    msg="Temperatura del server: {} ºC".format(temperaturapi)
    sleep (5)
    client.publish(topic,msg)