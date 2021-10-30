import paho.mqtt.client as mqtt
#sudo pip3 install paho-mqtt
from time import sleep
import os

broker_address = "192.168.1.111"
user = "Broker"
TopicTemperatura = "cuarto/temperatura"
TopicHumedad = "cuarto/humedad"
TopicResultados = "resultados"

client = mqtt.Client(user)
client.connect(broker_address)

def on_connect(client, userdata, flags, rc):
    client.subscribe(TopicTemperatura)
    client.subscribe(TopicHumedad)
    return()

def on_message(client, userdata, msg):
    topic = str(msg.topic)
    mensaje = str(msg.payload.decode("utf-8"))

    if topic == TopicTemperatura:
        if mensaje > "30.1":
            msg="Temperatura alta"
            client.publish(TopicResultados,msg)
    
    if topic == TopicHumedad:
        if mensaje > "28.1":
            msg="Humedad alta"
            client.publish(TopicResultados,msg)

    return()

client.on_connect = on_connect
client.on_message = on_message
client.loop_forever()