from string import punctuation
from time import sleep
from selenium import webdriver
import os
import sys


# Devuelve la ruta de el archivo que se le pasa por parametro
def buscarArchivoWindows(archivo):
    dir = str(sys.argv[0])  # Saber la ruta donde se ejecuta el archivo .py
    letra = dir[0:2]  # Buscar la letra de la unidad
    dir_base = letra + "\\" # Sumarle las barras para poner como directorio base la letra de la unidad
    enc = 0

    for root, folders, files in os.walk(dir_base):
        for file in files:
            if file == archivo:
                enc=1
                encontrado = os.path.join(root, file)
    if enc == 1:
        return encontrado
    else:
        return print("no se ha encontrado el archivo")


def luz(path):
    os.system("clear")
    options = webdriver.ChromeOptions()
    # añade el argumento --headless a optiones el cual permite que se ejecute chrome sin que se vea
    options.add_argument('--headless')
    # Para que no salgan warnings por la salida
    options.add_experimental_option('excludeSwitches', ['enable-logging'])

    # Ejecuta chrome con las opciones especificadas arriba #Si no le pasas argumentos se ejecuta normal
    driver = webdriver.Chrome(executable_path=path, options=options)




    driver.get("https://lucera.es/tarifas-luz-precio-fijo") 
    sleep(1)
    driver.find_element_by_id("onetrust-accept-btn-handler").click()
    sleep(1)
    precio_punta = driver.find_element_by_xpath("//*[@id='lx-main']/section[5]/div/div[2]/div[2]/div/div/div[4]/div[2]/span[1]")
    precio_valle = driver.find_element_by_xpath("//*[@id='lx-main']/section[5]/div/div[2]/div[2]/div/div/div[4]/div[4]/span[1]")

    precio_puntaF=float(precio_punta.text.replace(',','.'))
    precio_valleF=float(precio_valle.text.replace(',','.'))

    driver.get("https://clientes.lucera.es/acceso/usuario")
    sleep(2)
    usuario = driver.find_element_by_name("neon-input-0")
    usuario.send_keys("77356889T")  # Introduce el usuario
    sleep(2)
    driver.find_element_by_class_name("button-primary").click()
    sleep(2)
    contrasenia = driver.find_element_by_name("neon-input-1")
    contrasenia.send_keys("11AP2Nagz!")  # Introduce la contraseña
    sleep(2)
    driver.find_element_by_class_name("button-primary").click()

    sleep(8)
    fecha = driver.find_element_by_xpath("/html/body/app-root/ion-app/ion-content/ion-router-outlet/app-consumption/ion-content/div[2]/div/div[2]/div/div[1]/div[1]/div/app-current-electricity-consumption/app-chart-wrapper/div/div[2]/div/span")
    punta = driver.find_element_by_xpath("/html/body/app-root/ion-app/ion-content/ion-router-outlet/app-consumption/ion-content/div[2]/div/div[2]/div/div[1]/div[1]/div/app-current-electricity-consumption/app-chart-wrapper/div/div[3]/div[1]/div[2]/div[2]/div/app-chart-legend[1]/div/div[2]/span")
    valle = driver.find_element_by_xpath("/html/body/app-root/ion-app/ion-content/ion-router-outlet/app-consumption/ion-content/div[2]/div/div[2]/div/div[1]/div[1]/div/app-current-electricity-consumption/app-chart-wrapper/div/div[3]/div[1]/div[2]/div[2]/div/app-chart-legend[2]/div/div[2]/span")
    
    ########

    puntaF = float(punta.text[:4].replace(',','.'))
    valleF = float(valle.text[:4].replace(',','.'))
    fechaF = float(fecha.text[19:])

    precio_final_punta = puntaF * precio_puntaF
    precio_final_valle = valleF * precio_valleF

    precioPotencia = 0.570651*3.45
    precioEnergia = precio_final_punta+precio_final_valle
    impuestoElectricidad = precioEnergia * 0.115
    cuota = 4.95
    alquilerContador = 0.02663 * fechaF
    bonoSocial = 0.65

    precioSinIVA = bonoSocial+alquilerContador+cuota+precioEnergia+precioPotencia+impuestoElectricidad+9.85

    precioSinIVA = precioSinIVA * 28 / fechaF

    precioConIVA = precioSinIVA +(precioSinIVA*0.21)

    print("Dias contados: {}".format(fechaF))
    print("La luz nos va a costar este mes: {}€".format(round(precioConIVA,2)))
    print("Cada uno: {}€".format(precioConIVA/2))

    driver.quit()



ejecutable = buscarArchivoWindows("chromedriver.exe")
luz(ejecutable)
input("Presiona ENTER para finalizar...")