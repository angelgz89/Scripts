from multiprocessing import Process
from time import sleep

def funcion(pais):
    #sleep (3)
    print("El nombre del pais es: ", pais)
    
def funcion2():
    print("prueba")

if __name__ == "__main__":  # confirms that the code is under main function

    pais="España"
    proc = Process(target=funcion, args=(pais,))
    proc.start()

    proc = Process(target=funcion2)
    proc.start()

    # complete the processes
    #for proc in procs:
        #proc.join()