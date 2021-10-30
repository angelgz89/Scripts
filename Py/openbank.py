
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

def accesoOpenBank():
    
    lista = []

    if os.name == "posix":
        path = buscarArchivo("chromedriver")
    if os.name == "nt":
        path = buscarArchivo("chromedriver.exe")

    options = webdriver.ChromeOptions()
    # añade el argumento --headless a optiones el cual permite que se ejecute chrome sin que se vea
    options.add_argument('--headless')
    
    #options.add_argument('disable-infobars')
    #options.add_argument('--start-maximized')
    #options.add_argument('--no-sandbox')

    # Para que no salgan warnings por la salida
    options.add_experimental_option('excludeSwitches', ['enable-logging'])

    # Ejecuta chrome con las opciones especificadas arriba #Si no le pasas argumentos se ejecuta normal
    driver = webdriver.Chrome(executable_path=path, options=options)
    # Sin esta funcion no funciona la descarga por headless

    driver.get("https://www.openbank.es/")  # Accede a la URL

    sleep(2)
    driver.find_element_by_xpath("//*[@id='__tealiumGDPRecModal']/div[1]/div/div[3]/div[2]/div[2]/button[1]").click()
    sleep(2)
    driver.find_element_by_xpath("/html/body/div[1]/header/div/div[2]/div[1]/div[2]/div[2]/div[2]").click()
    
    sleep(2)
    usuario = driver.find_element_by_xpath("/html/body/div[1]/aside/div/div/div[1]/div/div/div[3]/div[3]/div/input")
    usuario.send_keys("77356889T")
    contraseña = driver.find_element_by_xpath("/html/body/div[1]/aside/div/div/div[1]/div/div/div[3]/div[5]/div/div/input")
    contraseña.send_keys("9")
    contraseña.send_keys("7")
    contraseña.send_keys("6")
    contraseña.send_keys("6")
    driver.find_element_by_xpath("/html/body/div[1]/aside/div/div/div[1]/div/div/div[3]/div[6]/button").click()
    sleep(2)
    
    driver.get("https://clientes.openbank.es/myprofile/accounts")
    sleep(3)
    driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div[3]/div[1]/div/div[2]/div[1]/div/div[2]/div/div/div[1]/div/div[2]/div/div[2]/div/div[1]/div[1]/div/section[1]/div[1]/div[1]/div/a").click()
    dinero = driver.find_element_by_xpath("//*[@id='app']/div/div[1]/div[3]/div[1]/div/div[2]/div[1]/div/div[1]/div/div/div/div/div[2]/div[2]/div[1]/div[1]/div[1]/span[1]/span/span[1]")
    lista.append(float(dinero.text.replace(',','.')))
    
    driver.get("https://clientes.openbank.es/myprofile/accounts")
    sleep(3)
    driver.find_element_by_xpath("//*[@id='account-box-header0']/section[1]/div[1]/div[1]/div/a").click()
    gastos = driver.find_element_by_xpath("//*[@id='app']/div/div[1]/div[3]/div[1]/div/div[2]/div[1]/div/div[1]/div/div/div/div/div[2]/div[2]/div[1]/div[1]/div[1]/span[1]/span/span[1]")
    lista.append(float(gastos.text.replace(',','.')))


    driver.quit()
    driver.quit()

    return lista

#######################################################

lista = accesoOpenBank()

print("Dinero en la cuenta: {}".format(lista[0]))
print("Dinero en la cuenta de gastos: {}".format(lista[1]))

fin = time.time()
tiempo = (fin-inicio)
print("Tiempo de ejecucion: {} segundos".format(round(tiempo, 1)))