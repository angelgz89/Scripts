import gspread
from gspread.urls import SPREADSHEET_SHEETS_COPY_TO_URL
from oauth2client.service_account import ServiceAccountCredentials

alcance  = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive']
creds  =  ServiceAccountCredentials.from_json_keyfile_name('inversion-313707-c4dc97948892.json',alcance)
client = gspread.authorize(creds)

# obtener la instancia de la hoja de cálculo
# tiene que darle permiso en la hoja al correo
# inversion@inversion-313707.iam.gserviceaccount.com
hoja = client.open("hola")

# obtener la primera hoja de la hoja de cálculo
sheet  =  hoja.get_worksheet(0)


# get the value at the specific cell
#prueba = sheet.cell(col=2,row=3)
sheet.update_acell("B1", "Oleeeeee")

print(sheet.find("Oleeeeee"))


valor = sheet.acell("B1")
valor2 = sheet.cell(1,2)
lista = sheet.col_values(2)
print(valor)
print(valor2)
print(lista)