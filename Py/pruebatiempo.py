from multiprocessing import Process
from time import sleep
import random


def funcion():
    while True:
        sleep(random.randint(2, 5))
        print ('prueba1 \n')
        # sleep(20)
    
def funcion2():
    while True:
        sleep(random.randint(2, 5))
        print("prueba2 \n")
        # sleep(20)

def funcion3():
    while True:
        sleep(random.randint(2, 5))
        print("prueba3 \n")

if __name__ == "__main__":  # confirms that the code is under main function

    proc = Process(target=funcion)
    proc.start()

    proc = Process(target=funcion2)
    proc.start()

    proc = Process(target=funcion3)
    proc.start()
