
import shutil
import os

def escribirFichero (rutaFichero,listaEscribir):
    with open(rutaFichero, 'w') as fichero:
        for linea in listaEscribir:
            fichero.write(linea + '\n')
    
def leerFichero(rutaFichero):
    lista_archivos = []
    #mete la lista del fichero en una lista
    with open(rutaFichero, 'r') as reader:
        for linea in reader:
            lista_archivos.append(linea.rstrip())
    return lista_archivos


def encontrar():

    total = 0
    encontrados = []
    lista_archivos = []
    os.system("clear")

    origen = input ("En que ruta deseas buscar: ")
    os.system("clear")

    opcion = input ("Donde deseas buscar en [A]rchivo o por [N]ombre: ")
    os.system("clear")
    while opcion != "A" and opcion != "N":
        opcion = input ("Donde deseas buscar en [A]rchivo o por [N]ombre: ")

    if opcion == "A":
        ruta = input ("Introduce la ruta del archivo a leer: ")
        lista_archivos = leerFichero(ruta[1 : -1]) 
        for root, dir, ficheros in os.walk(origen[1 : -1]):
            for fichero in ficheros:
                for nombre in lista_archivos:
                    resultado = fichero.find(nombre)
                    if resultado != -1:
                        encontrados.append(root+"\\"+fichero)
                        total += 1
        print ("Has encontrado {} archivo[s]".format(total))
        return encontrados

    if opcion == "N":
        nombre = input ("Introduce el nombre o parte del nombre del archivo a buscar: ")

        if isinstance(nombre, str):
            for root, dir, ficheros in os.walk(origen[1 : -1]):
                for fichero in ficheros:
                    if(nombre in fichero):
                        encontrados.append(root+"\\"+fichero)
                        total += 1
            print ("Fichero encontrado")
            return encontrados
        else:
            print("Has introducido un archivo")
            return -1


def mover (ruta):
    destino = input("Introduce la ruta donde quieres poner los archivos encontrados: ")
    destino = destino[1 : -1]
    for file in ruta:
        shutil.copy(file, destino)


#####################################

encontrados = encontrar()
if encontrados != -1:
    mover(encontrados)
