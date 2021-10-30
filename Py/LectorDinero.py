# -*- coding: utf-8 -*-

# IMPORTACIONES

from time import sleep
import os
import os.path
import sys
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By

# Devuelve la ruta de el archivo que se le pasa por parametro
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


def accesoBBVA():

    lista = []

    if os.name == "posix":
        path = buscarArchivo("chromedriver")
    if os.name == "nt":
        path = buscarArchivo("chromedriver.exe")

    options = webdriver.ChromeOptions()
    #options.add_argument('--headless')
    options.add_experimental_option('excludeSwitches', ['enable-logging'])
    driver = webdriver.Chrome(executable_path=path, options=options)

##############################################

    driver.get("https://www.bbva.es/personas.html")  # Accede a la URL
    

    driver.maximize_window()
    sleep(2)
    driver.find_element(By.CLASS_NAME, "cookiesgdpr__acceptbtn").click()
    sleep(2)
    driver.find_element_by_xpath("//*[@id='root']/div/div/form/div[2]/label").click()
    sleep(3)
    usuario = driver.find_element_by_xpath("//*[@id='a2779220-4c19-4445-b4f9-a4450696b746']")
    usuario.send_keys("77356889T")

    # sleep(5)
    # WebDriverWait(driver, 5)\
    # .until(EC.element_to_be_clickable((By.CSS_SELECTOR,
    #                                   'name#user')))\
    # .send_keys('77356889T')





    # driver.find_element_by_class_name("c-button--secondary m-login__button".replace(' ', '.')).click()
    # sleep(5)

    # driver.quit()




#MAIN PROGRAM
accesoBBVA()
print("Programa finalizado")
