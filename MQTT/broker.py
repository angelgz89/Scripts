import paho.mqtt.client as mqtt
#sudo pip3 install paho-mqtt
from time import sleep
import os

broker_address = "192.168.1.111"
user = "Broker"
Topic1 = "prueba1"

client = mqtt.Client(user)
client.connect(broker_address)

def on_connect(client, userdata, flags, rc):
    # Inicio o renovación de subscripción
    client.subscribe(Topic1)
    return()

def on_message(client, userdata, msg):
    mensaje = str(msg.payload.decode("utf-8"))

    Topic2="prueba2"
    if mensaje == "antonio":
        temperaturapi=float(os.popen('cat /sys/class/thermal/thermal_zone0/temp').read())/1000
        msg="Temperatura del server: {} ºC".format(temperaturapi)
        client.publish(Topic2,msg)

    return()


client.on_connect = on_connect
client.on_message = on_message
client.loop_forever()