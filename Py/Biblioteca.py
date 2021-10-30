from time import sleep
import os
import os.path
import sys
from getpass import getuser

os.system('clear')

cosa = input("Dame cosas: \n")

os.system('clear')
print("Toma tu cosa: " + cosa)

SO = os.name

if SO == "posix":

    veces = int(input("Cuantas veces quieres tu cosa?\n"))

    #Para usar el for con input, tienes que pasarlo a int y para contar la variable poner range

    print("quieres hacer tus mierdas: {} veces".format(veces))

    for vez in range(veces):
        print(vez)


    lista=["cosa1","cosa2"]
    print (lista[0])


    while cosa != "hola":
        print("especifica mas por favor")
        cosa = input("Dame cosas: \n")

    if cosa == "hola":
        print("hola guapo")

else:
    print("estas en : {}".format(SO))
