import os

rutaFichero = "C:\\Users\\agz27\\OneDrive\\Escritorio\\texto.txt"

def escribirFichero (rutaFichero,listaEscribir):
    with open(rutaFichero, 'w') as fichero:
        for linea in listaEscribir:
            fichero.write(linea + '\n')


ejemplo_dir = "C:\\Users\\agz27\OneDrive\Escritorio\\Nueva carpeta"
contenido = os.listdir(ejemplo_dir)

archivos = []

for root, dir, ficheros in os.walk(ejemplo_dir):
    for fichero in ficheros:
        archivos.append(fichero.split(".")[0])


escribirFichero(rutaFichero,archivos)