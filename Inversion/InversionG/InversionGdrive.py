# INSTALACIONES
# import subprocess
# import sys

# def install(package):
#     subprocess.call([sys.executable, "-m", "pip3", "-q", "install", package])
    
# install('gspread')
# install('oauth2client')
# install('selenium')

import gspread
from oauth2client.service_account import ServiceAccountCredentials
from time import sleep
from selenium import webdriver
from datetime import date
import os
import os.path
import sys
import time
inicio = time.time()

if os.name == "posix":
    os.system('clear')
if os.name == "nt":
    os.system('cls')

# FUNCIONES
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

##CONEXION GDRIVE
def conexionGdriveInversion():
    
    alcance  = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive']
    creds  =  ServiceAccountCredentials.from_json_keyfile_name(buscarArchivo("inversion-313707-c4dc97948892.json"),alcance)
    client = gspread.authorize(creds)

    # obtener la instancia de la hoja de cálculo
    # tiene que darle permiso en la hoja al correo
    # inversion@inversion-313707.iam.gserviceaccount.com
    Inversion = client.open("Inversion")
    return Inversion

def accesoInversis():
    
    lista = []

    if os.name == "posix":
        path = buscarArchivo("chromedriver")
    if os.name == "nt":
        path = buscarArchivo("chromedriver.exe")

    options = webdriver.ChromeOptions()
    # añade el argumento --headless a optiones el cual permite que se ejecute chrome sin que se vea
    options.add_argument('--headless')
    # Para que no salgan warnings por la salida
    options.add_experimental_option('excludeSwitches', ['enable-logging'])

    # Ejecuta chrome con las opciones especificadas arriba #Si no le pasas argumentos se ejecuta normal
    driver = webdriver.Chrome(executable_path=path, options=options)
    # Sin esta funcion no funciona la descarga por headless

    driver.get("https://www.inversis.com/?cobranding=cbandbank")  # Accede a la URL
    # Accede a un elemento de la pagina web mediante la clase y clicka
    driver.find_element_by_class_name("btns").click()
    # Accede a un elemento de la pagina web mediante la el nombre y marca para despues escribir
    usuario = driver.find_element_by_name("codigoUsuario")
    # Accede a un elemento de la pagina web mediante la el nombre y marca para despues escribir
    contrasenia = driver.find_element_by_name("claveUsuario")

    usuario.send_keys("agz2712")  # Introduce el usuario
    contrasenia.send_keys("11AP2Nagz")  # Introduce la contraseña
    sleep(1)
    # Accede a un elemento de la pagina web mediante la el nombre y clicka
    driver.find_element_by_name("entrar").click()

    sleep(2)
    driver.get("https://www.inversis.com/trans/inversis/SvlConsultarCarteraReal?CABECERA.TIPO_PRODUCTO=CV&origen=DETALLE")

    fund = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_603988']")
    fund = float(fund.text.replace('.','').replace(',','.'))
    lista.append(fund)

    jpm = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_96241']")
    jpm = float(jpm.text.replace('.','').replace(',','.'))
    lista.append(jpm)

    mfs = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_261962']")
    mfs=float(mfs.text.replace('.','').replace(',','.'))
    lista.append(mfs)

    vanguard = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_459341']")
    vanguard=float(vanguard.text.replace('.','').replace(',','.'))
    lista.append(vanguard)

    affinium = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_786408']")
    affinium=float(affinium.text.replace('.','').replace(',','.'))
    lista.append(affinium)

    baelo = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_622586']")
    baelo=float(baelo.text.replace('.','').replace(',','.'))
    lista.append(baelo)

    cp = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_588240']")
    cp=float(cp.text.replace('.','').replace(',','.'))
    lista.append(cp)

    hidro = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_759804']")
    hidro=float(hidro.text.replace('.','').replace(',','.'))
    lista.append(hidro)

    truev = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_376662']")
    truev=float(truev.text.replace('.','').replace(',','.'))
    lista.append(truev)

    driver.quit()
    driver.quit()

    return lista

def actualizarexcel():
    
    lista = accesoInversis()

    fecha = date.today()
    dia = int(fecha.day)
    mes = int(fecha.month)
    anio = str(fecha.year)
    
    if dia >= 2:
        mes = mes +1

    Inversion = conexionGdriveInversion()
    Inversion2021  =  Inversion.worksheet(anio)

    rangoBaelo = ("C" + str(3 + mes))
    rangoCP = ("W" + str(3 + mes))
    rangoTrue = ("M" + str(3 + mes))
    rangoVanguard = ("C" + str(21 + mes))
    rangoMFS = ("W" + str(21 + mes))
    rangoFundsmith = ("M" + str(21 + mes))
    rangoAffinium = ("C" + str(39 + mes))
    rangoJPMTEC = ("M" + str(39 + mes))
    rangoHidro = ("W" + str(39 + mes))

    Inversion2021.update_acell(rangoFundsmith, lista[0])
    Inversion2021.update_acell(rangoJPMTEC, lista[1])
    Inversion2021.update_acell(rangoMFS, lista[2])
    Inversion2021.update_acell(rangoVanguard, lista[3])
    Inversion2021.update_acell(rangoAffinium, lista[4])
    Inversion2021.update_acell(rangoBaelo, lista[5])
    Inversion2021.update_acell(rangoCP, lista[6])
    Inversion2021.update_acell(rangoHidro,lista[7])
    Inversion2021.update_acell(rangoTrue, lista[8])

def media():
    
    fecha = date.today()
    inicio = date(2020,1,1)
    dias = fecha - inicio

    if(fecha.month) == "2020":
        meses = (int(dias.days)/30)+1
    else:
        meses = (int(dias.days)/30)-1
    
    Inversion = conexionGdriveInversion()
    Resumen  =  Inversion.worksheet("Resumen")

    Total = (Resumen.acell("D11").value)
    total = float(Total[:6].replace(',','.'))
    media = total/meses

    Resumen.update_acell("D13", int(meses))
    Resumen.update_acell("D12", media)

def MostrarResultados():
    
    Inversion = conexionGdriveInversion()
    Resumen  =  Inversion.worksheet("Resumen")

    total = Resumen.acell("D11").value
    twr = Resumen.acell("E11").value
    print("Total: {} - TWR: {}".format(total,twr))

    meses = Resumen.acell("D13").value
    print("Meses invertido: {}".format(meses))

    media = Resumen.acell("D12").value
    print("Ganancias mensuales: {}".format(media))

###########################################################

media()
MostrarResultados()

fin = time.time()
tiempo = (fin-inicio)
print("Tiempo de ejecucion: {} segundos".format(round(tiempo, 1)))