from flask import Flask, render_template
import gspread
from oauth2client.service_account import ServiceAccountCredentials
import os


##CONEXION GDRIVE
def conexionGdriveInversion():
    
    alcance  = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive']
    creds  =  ServiceAccountCredentials.from_json_keyfile_name("/home/angel/MisDocumentos/Servidores/inversion-313707-c4dc97948892.json",alcance)
    client = gspread.authorize(creds)

    # obtener la instancia de la hoja de cálculo
    # tiene que darle permiso en la hoja al correo
    # inversion@inversion-313707.iam.gserviceaccount.com
    Inversion = client.open("Inversion")
    return Inversion

Inversion = conexionGdriveInversion()

app = Flask(__name__)

usuario = "Angel"

@app.route('/')
def home():
     return render_template("home.html", 
                            usuario=usuario)

@app.route('/inversiones')
def inversiones():
    Resumen  =  Inversion.worksheet("Resumen")
    Cartera = Inversion.worksheet("Cartera 2021")
    # dosmil21 = Inversion.worksheet("2021")

    totalb = Resumen.acell("D8").value
    twrb = Resumen.acell("F8").value

    totaln = Resumen.acell("E8").value
    twrn = Resumen.acell("G8").value

    meses = Resumen.acell("C2").value

    mediab = Resumen.acell("D9").value
    median = Resumen.acell("E9").value

    twr = Cartera.acell("L4").value
    vol = Cartera.acell("O4").value
    sharpe = Cartera.acell("P4").value



    # BaeloTWR = dosmil21.acell("AG5").value
    # BaeloTWRMedio = dosmil21.acell("AH5").value
    # Baelog = dosmil21.acell("AI5").value
    # BaeloVol = dosmil21.acell("AJ5").value
    # BaeloSharpe = dosmil21.acell("AK5").value

    # VanguardTWR = dosmil21.acell("AG6").value
    # VanguardTWRMedio = dosmil21.acell("AH6").value
    # Vanguardg = dosmil21.acell("AI6").value
    # VanguardVol = dosmil21.acell("AJ6").value
    # VanguardSharpe = dosmil21.acell("AK6").value
    
    # AffiniumTWR =dosmil21.acell("AG7").value
    # AffiniumTWRMedio = dosmil21.acell("AH7").value
    # Affiniumg = dosmil21.acell("AI7").value
    # AffiniumVol = dosmil21.acell("AJ7").value
    # AffiniumSharpe = dosmil21.acell("AK7").value
    
    # TrueValueTWR = dosmil21.acell("AG8").value
    # TrueValueTWRMedio = dosmil21.acell("AH8").value
    # TrueValueg = dosmil21.acell("AI8").value
    # TrueValueVol = dosmil21.acell("AJ8").value
    # TrueValueSharpe = dosmil21.acell("AK8").value
    
    # FundSmithTWR =dosmil21.acell("AG9").value
    # FundSmithTWRMedio = dosmil21.acell("AH9").value
    # FundSmithg = dosmil21.acell("AI9").value
    # FundSmithVol = dosmil21.acell("AJ9").value
    # FundSmithSharpe = dosmil21.acell("AK9").value
    
    # CPTWR = dosmil21.acell("AG11").value
    # CPTWRMedio = dosmil21.acell("AH11").value
    # CPg = dosmil21.acell("AI11").value
    # CPVol = dosmil21.acell("AJ11").value
    # CPSharpe = dosmil21.acell("AK11").value
    
    # MFSTWR = dosmil21.acell("AG12").value
    # MFSTWRMedio = dosmil21.acell("AH12").value
    # MFSg = dosmil21.acell("AI12").value
    # MFSVol = dosmil21.acell("AJ12").value
    # MFSSharpe = dosmil21.acell("AK12").value
    
    
    return render_template('inversiones.html', 
                           usuario=usuario,
                           totalb=totalb, 
                           twrb=twrb,
                           totaln=totaln, 
                           twrn=twrn,
                           meses=meses, 
                           mediab=mediab,
                           median=median,
                           twr=twr,
                           vol=vol,
                           sharpe=sharpe
                        #    BaeloTWR=BaeloTWR,
                        #    BaeloTWRMedio=BaeloTWRMedio,
                        #    Baelog=Baelog,
                        #    BaeloVol=BaeloVol,
                        #    BaeloSharpe=BaeloSharpe,
                        #    VanguardTWR=VanguardTWR,
                        #    VanguardTWRMedio=VanguardTWRMedio,
                        #    Vanguardg=Vanguardg,
                        #    VanguardVol=VanguardVol,
                        #    VanguardSharpe=VanguardSharpe,
                        #    AffiniumTWR=AffiniumTWR,
                        #    AffiniumTWRMedio=AffiniumTWRMedio,
                        #    Affiniumg=Affiniumg,
                        #    AffiniumVol=AffiniumVol,
                        #    AffiniumSharpe=AffiniumSharpe,
                        #    TrueValueTWR=TrueValueTWR,
                        #    TrueValueTWRMedio=TrueValueTWRMedio,
                        #    TrueValueg=TrueValueg,
                        #    TrueValueVol=TrueValueVol,
                        #    TrueValueSharpe=TrueValueSharpe,
                        #    FundSmithTWR=FundSmithTWR,
                        #    FundSmithTWRMedio=FundSmithTWRMedio,
                        #    FundSmithg=FundSmithg,
                        #    FundSmithVol=FundSmithVol,
                        #    FundSmithSharpe=FundSmithSharpe,
                        #    CPTWR=CPTWR,
                        #    CPTWRMedio=CPTWRMedio,
                        #    CPg=CPg,
                        #    CPVol=CPVol,
                        #    CPSharpe=CPSharpe,
                        #    MFSTWR=MFSTWR,
                        #    MFSTWRMedio=MFSTWRMedio,
                        #    MFSg=MFSg,
                        #    MFSVol=MFSVol,
                        #    MFSSharpe=MFSSharpe
                           )

@app.route('/dieta')
def dieta():
     return render_template("dieta.html", 
                            usuario=usuario)

@app.route('/pruebas')
def pruebas():
     return render_template("pruebas.html", 
                            usuario=usuario)






# Make sure this we are executing this file
if __name__ == '__main__':
    app.run(debug=True, host='192.168.1.111', port=80)
