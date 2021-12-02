# -*- coding: utf-8 -*-

import gspread
from oauth2client.service_account import ServiceAccountCredentials

import selenium
from selenium import webdriver
from selenium.webdriver.common.by import By

from time import sleep
from datetime import date
from dateutil import rrule

import os
import os.path
import sys
import time
inicio = time.time()

#sudo apt install chromium-driver
#sudo apt-get install chromium-chromedriver

CARPETAUSERPASS = os.environ["HOME"] + "/Servidor/userpass.txt"
FILEKEY = os.environ["HOME"] + "/Servidor/inversion-clave.json"

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
def conexionGdrive():
    
    alcance  = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive']
    creds  =  ServiceAccountCredentials.from_json_keyfile_name((FILEKEY), alcance)
    client = gspread.authorize(creds)

    # obtener la instancia de la hoja de calculo
    # tiene que darle permiso en la hoja al correo
    # inversion@inversion-313707.iam.gserviceaccount.com
    Inversion = client.open("Inversion")
    return Inversion

Inversion = conexionGdrive()
Resumen  =  Inversion.worksheet("Resumen")
Cartera = Inversion.worksheet("Cartera")

def accesoInversis():
     
    lista = []

    options = webdriver.ChromeOptions()
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--disable-gpu')
    options.add_argument('--profile-directory=Default')
    options.add_argument('--user-data-dir=/tmp')
    options.add_experimental_option('excludeSwitches', ['enable-logging'])

    # Ejecuta chrome con las opciones especificadas arriba #Si no le pasas argumentos se ejecuta normal
    #driver = webdriver.Chrome(executable_path=path, options=options)
    driver = webdriver.Chrome(options=options)
    #driver = webdriver.Chrome()

    driver.get("https://www.inversis.com/?cobranding=cbandbank")  # Accede a la URL
    # Accede a un elemento de la pagina web mediante la clase y clicka
    #driver.find_element_by_class_name("btns").click()
    driver.find_element(By.CLASS_NAME, "btns").click()

    # Accede a un elemento de la pagina web mediante la el nombre y marca para despues escribir
    #usuario = driver.find_element_by_name("codigoUsuario")
    usuario = driver.find_element(By.NAME, "codigoUsuario")
    # Accede a un elemento de la pagina web mediante la el nombre y marca para despues escribir
    #contrasenia = driver.find_element_by_name("claveUsuario")
    contrasenia = driver.find_element(By.NAME, "claveUsuario")

    fichero = open(CARPETAUSERPASS)
    user = fichero.readline().rstrip('\n')
    passs = fichero.readline().rstrip('\n')
    fichero.close()

    usuario.send_keys(user)  # Introduce el usuario
    contrasenia.send_keys(passs)  # Introduce la contraseña
    sleep(1)

    # Accede a un elemento de la pagina web mediante la el nombre y clicka
    #driver.find_element_by_name("entrar").click()
    driver.find_element(By.NAME, "entrar").click()

    sleep(5)
    driver.get("https://www.inversis.com/trans/inversis/SvlConsultarCarteraReal?CABECERA.TIPO_PRODUCTO=CV&origen=DETALLE")

    #fund = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_603988']")
    fund = driver.find_element(By.XPATH, "//*[@id='contraValorEURActual_B1_603988']")
    fund = float(fund.text.replace('.','').replace(',','.'))
    lista.append(fund)

    #mfs = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_261962']")
    mfs = driver.find_element(By.XPATH, "//*[@id='contraValorEURActual_B1_261962']")
    mfs=float(mfs.text.replace('.','').replace(',','.'))
    lista.append(mfs)

    #vanguard = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_459341']")
    vanguard = driver.find_element(By.XPATH, "//*[@id='contraValorEURActual_B1_459341']")
    vanguard=float(vanguard.text.replace('.','').replace(',','.'))
    lista.append(vanguard)

    #affinium = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_786408']")
    affinium = driver.find_element(By.XPATH, "//*[@id='contraValorEURActual_B1_786408']")
    affinium=float(affinium.text.replace('.','').replace(',','.'))
    lista.append(affinium)

    #baelo = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_622586']")
    baelo = driver.find_element(By.XPATH, "//*[@id='contraValorEURActual_B1_622586']")
    baelo=float(baelo.text.replace('.','').replace(',','.'))
    lista.append(baelo)

    #cp = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_588240']")
    cp = driver.find_element(By.XPATH, "//*[@id='contraValorEURActual_B1_588240']")
    cp=float(cp.text.replace('.','').replace(',','.'))
    lista.append(cp)

    #truevalue = driver.find_element_by_xpath("//*[@id='contraValorEURActual_B1_376662']")
    truevalue = driver.find_element(By.XPATH, "//*[@id='contraValorEURActual_B1_376662']")
    truevalue=float(truevalue.text.replace('.','').replace(',','.'))
    lista.append(truevalue)

    driver.quit()
    driver.quit()

    return lista

def actualizarexcel():
    
    lista = accesoInversis()

    fecha = date.today()

    dia = int(fecha.day)
    mes = int(fecha.month)
    anio = str(fecha.year)
    
    if mes == 12:
        if dia >= 2:
            mes = 1
            anio = int(anio)+1
            anio = str(anio)
        if dia == 1:
            if dia >= 2:
                mes = mes + 1
    else:
        if dia >= 2:
            mes = mes + 1

    # Grabar total anterior
    #Resumen  =  Inversion.worksheet("Resumen")
    # totalanterior = Resumen.acell("D8").value
    # Resumen.update_acell("D12",totalanterior)
    
    Inversion1  =  Inversion.worksheet(anio)

    rangoBaelo = ("C" + str(3 + mes))
    rangoCP = ("W" + str(3 + mes))
    rangoTrue = ("M" + str(3 + mes))
    rangoVanguard = ("C" + str(21 + mes))
    rangoMFS = ("W" + str(21 + mes))
    rangoFundsmith = ("M" + str(21 + mes))
    rangoAffinium = ("C" + str(39 + mes))
    # rangoJPMTEC = ("M" + str(39 + mes))
    # rangoHidro = ("W" + str(39 + mes))

    Inversion1.update_acell(rangoFundsmith, lista[0])
    #Inversion1.update_acell(rangoJPMTEC, lista[1])
    Inversion1.update_acell(rangoMFS, lista[1])
    Inversion1.update_acell(rangoVanguard, lista[2])
    Inversion1.update_acell(rangoAffinium, lista[3])
    Inversion1.update_acell(rangoBaelo, lista[4])
    Inversion1.update_acell(rangoCP, lista[5])
    #Inversion1.update_acell(rangoHidro,lista[7])
    Inversion1.update_acell(rangoTrue, lista[6])

def media():
    
    d1 = date(2021, 1, 1)
    d2 = date.today()

    meses = rrule.rrule(rrule.MONTHLY, dtstart=d1, until=d2).count()

    #Resumen  =  Inversion.worksheet("Resumen")

    Total = Resumen.acell("D8").value
    total = float(Total[:8].replace('.', '').replace(',', '.'))
    media = total/meses

    Resumen.update_acell("C2", int(meses))
    Resumen.update_acell("D9", media)

def MostrarResultados():
    
    #Resumen  =  Inversion.worksheet("Resumen")

    totalb = Resumen.acell("D8").value
    mwrb = Resumen.acell("F8").value
    print("Ganancias brutas: {} - MWR bruto: {}".format(totalb,mwrb))

    totaln = Resumen.acell("E8").value
    mwrn = Resumen.acell("G8").value
    print("Ganancias netas: {} - MWR neto: {}".format(totaln,mwrn))

    mediab = Resumen.acell("D9").value
    print("Ganancias mensuales brutas: {}".format(mediab))
    median = Resumen.acell("E9").value
    print("Ganancias mensuales netas: {}".format(median))

    meses = Resumen.acell("C2").value
    print("Meses invertido: {}".format(meses))

    print()

    TWR = Cartera.acell("L4").value
    print("TWR de la inversion: {}".format(TWR))
    TWRM = Cartera.acell("M4").value
    print("TWR de la inversion: {}".format(TWRM)) 
    VOLT = Cartera.acell("O4").value
    print("Volatilidad de la inversion: {}".format(VOLT))
    SHARPE = Cartera.acell("P4").value
    print("Sharpe de la inversion: {}".format(SHARPE))

###########################################################

actualizarexcel()
media()
MostrarResultados()

fin = time.time()
print()
print("Tiempo de ejecucion: {} segundos".format(round(fin-inicio,2)))