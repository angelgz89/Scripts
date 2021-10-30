#!/usr/bin/python

# IMPORTACIONES

from time import sleep
from selenium import webdriver
from datetime import date
import os
import os.path
if os.name == "nt":
    import win32com.client
import sys
import openpyxl


if os.name == "posix":
    os.system('clear')
if os.name == "nt":
    os.system('cls')

#DECLARACIONES
EXCELINVERSION = "Inversion.xlsm"
EXCELSALIDA = "salida.xls"

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

# Web scraping
def accesoInversis():
    
    lista = []

    if os.name == "posix":
        directorio_descarga = "/Users/angel/Downloads/"
        path = buscarArchivo("chromedriver")
    if os.name == "nt":
        directorio_descarga = "C:\\Users\\"+os.getlogin()+"\\Downloads"
        path = buscarArchivo("chromedriver.exe")

    options = webdriver.ChromeOptions()
    # añade el argumento --headless a optiones el cual permite que se ejecute chrome sin que se vea
    options.add_argument('--headless')
    # Para que no salgan warnings por la salida
    options.add_experimental_option('excludeSwitches', ['enable-logging'])

    # Ejecuta chrome con las opciones especificadas arriba #Si no le pasas argumentos se ejecuta normal
    driver = webdriver.Chrome(executable_path=path, options=options)
    # Sin esta funcion no funciona la descarga por headless

    #Habilitar descarga modo navegador oculto
    driver.command_executor._commands["send_command"] = ("POST", '/session/$sessionId/chromium/send_command')
    params = {'cmd': 'Page.setDownloadBehavior', 'params': {'behavior': 'allow', 'downloadPath': directorio_descarga}}
    driver.execute("send_command", params)

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

    sleep(5)
    driver.get("https://www.inversis.com/trans/inversis/SvlConsultarCarteraReal?CABECERA.TIPO_PRODUCTO=CV&origen=DETALLE")


    if os.name == "posix":
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

    if os.name == "nt":
            sleep(2)
            #DESCARGA EL EXCEL
            driver.find_element_by_xpath("//*[@id='listIcons']/ul/li[3]/a").click()
            sleep(2)
            lista.append("1")

    driver.quit()
    driver.quit()

    return lista

def actualizarexcel(rutaexcel, lista):
    fecha = date.today()
    dia = int(fecha.day)
    mes = int(fecha.month)
    anio = str(fecha.year)
    
    if dia >= 2:
        mes = mes +1

    excelInversion = openpyxl.load_workbook(rutaexcel, keep_vba=True)
    hojaCartera = excelInversion[anio]

    rangoBaelo = ("C" + str(3 + mes))
    rangoCP = ("W" + str(3 + mes))
    rangoTrue = ("M" + str(3 + mes))
    rangoVanguard = ("C" + str(21 + mes))
    rangoMFS = ("W" + str(21 + mes))
    rangoFundsmith = ("M" + str(21 + mes))
    rangoAffinium = ("C" + str(39 + mes))
    rangoJPMTEC = ("M" + str(39 + mes))
    rangoHidro = ("W" + str(39 + mes))

    hojaCartera[rangoFundsmith] = lista[0]
    hojaCartera[rangoJPMTEC] = lista[1]
    hojaCartera[rangoMFS] = lista[2]
    hojaCartera[rangoVanguard] = lista[3]
    hojaCartera[rangoAffinium] = lista[4]
    hojaCartera[rangoBaelo] = lista[5]
    hojaCartera[rangoCP] = lista[6]
    hojaCartera[rangoHidro] = lista[7]
    hojaCartera[rangoTrue] = lista[8]

    excelInversion.save(rutaexcel)
    excelInversion.close()

def ejecutarMacroExcel(rutaexcel,nombremacro):
    if os.path.exists(rutaexcel):
        xlApp = win32com.client.DispatchEx('Excel.Application')
        xlsPath = os.path.expanduser(rutaexcel)
        wb = xlApp.Workbooks.Open(Filename=xlsPath)
        xlApp.Run(nombremacro)
        wb.Save()
        wb.Close()
        xlApp.Quit()
    else:
        print("No se encuentra el fichero excel")

def resultadoInversion(excelinversion):

    ejecutarMacroExcel(excelinversion,'Copiar')

    Libro2 = openpyxl.load_workbook(excelinversion, data_only=True)
    hojaCartera2 = Libro2['Resumen']

    dinero = round(float(hojaCartera2['D11'].value),2)
    twr = round(float(hojaCartera2['E11'].value) * 100,2)
    patrimonio = float(hojaCartera2['C9'].value)

    print("Patrimonio: {} €".format(patrimonio))
    if dinero > 0:
        print("He ganado: {} €".format(dinero))
    else:
        print("He perdido: {} €".format(dinero))
    print("Total: {} €".format(patrimonio+dinero))
    print("TWR: {} %".format(twr))

###########################################################

rutaexcelinversion = buscarArchivo(EXCELINVERSION)
resultados = accesoInversis()

if os.name == "posix":
    actualizarexcel(rutaexcelinversion, resultados)
if os.name == "nt":
    resultadoInversion(rutaexcelinversion)

print("Proceso terminado")