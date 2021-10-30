from datetime import date
import os


fecha = date.today()
dia = str(fecha.day)
mes = str(fecha.month)
anio = str(fecha.year)

os.system('clear')
print("hoy es:", dia+"/"+mes+"/"+anio)