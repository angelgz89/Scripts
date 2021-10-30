
import os
import os.path
import xlwings as xw


def buscarArchivo(archivo):
    
    enc = 0
    
    if os.name == "posix":
        dir_base = "/"
    if os.name == "nt":    
        letra = str(sys.argv[0])[0:2]  # Buscar la letra de la unidad
        dir_base = letra + "\\" # Sumarle las barras para poner como directorio base la letra de la unidad
    
    for root, folders, files in os.walk(dir_base):
        for file in files:
            if file == archivo:
                enc=1
                encontrado = os.path.join(root, file)
    if enc == 1:
        return encontrado
    else:
        print("no se ha encontrado el archivo")
        return "-1"


rutaexcel = buscarArchivo("pruebasexcel.xlsx")


wbxl=xw.Book(rutaexcel)
#wbxl.sheets['Sheet'].range('B3').value = 3
print(wbxl.sheets['Sheet'].range('A1').value)