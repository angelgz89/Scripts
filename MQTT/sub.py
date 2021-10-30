import paho.mqtt.client as mqtt

servidormqtt = "192.168.1.111"
topicolee = "prueba2"


cuentamensaje = 0
nombrearchivo = 'unreporte.txt'
archivo = open(nombrearchivo,'w')
archivo.close()


def on_connect(client, userdata, flags, rc):
    # Inicio o renovación de subscripción
    client.subscribe(topicolee)
    return()

def on_message(client, userdata, msg):
    
    #print(str(msg.payload.decode("utf-8")))
    unmensaje = str(msg.payload.decode("utf-8"))

    # Archivo en modo añadir 'append'
    archivo = open(nombrearchivo,'a')
    unalinea = unmensaje + '\n'
    archivo.write(unalinea)

    #print('Mensajes recibidos: ', cuentamensaje)
    print(unmensaje)

    return()

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message
client.connect(servidormqtt, 1883)
client.loop_forever()