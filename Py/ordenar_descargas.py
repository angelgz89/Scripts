import os
import shutil
from getpass import getuser

# Aquí colocas tu ruta de descargas

if os.name == "posix":
    os.system('clear')
    route_downloads = "/Users/"+getuser()+"/Downloads/"
    getuser()
if os.name == "nt":
    os.system('cls')
    route_downloads = "C:\\Users\\"+os.getlogin()+"\\Downloads\\"

text_extensions = ['.txt', '.doc', '.docx', 'pptx', '.odf', '.docm', '.epub']
pdf_extensions = [".pdf"]
excel_extensions = ['.xls', '.xlsm', '.xlsx','.xltm']
video_extensions = ['.mov', '.mp4', '.avi', '.mkv', '.mkv', '.flv', '.wmv']
audio_extensions = ['.mp3', '.wma', '.wav', '.flac']
photo_extensions = ['.jpg', '.png', 'jpeg', '.gif', '.tiff', '.psd', '.bmp', '.ico', '.svg']
compressed_extensions = ['.zip', '.rar', '.rar5', '.7z', '.ace', '.gz']
executable_extensions = ['.exe', '.dmg', '.msi']
torrent_extensions = [".torrent"]
imagen_extensions = [".iso"]


def check_folders():
    necessary = ('Texto','Excel','PDF','Video','Sonido','Imagenes','Comprimidos','Programas','Otros','Torrents','ISO')

    all_files = os.listdir(route_downloads)
    missing_folders = []

    for n in necessary:

        len_files = len(all_files)
        progress = 0
        
        for f in all_files:
            if f != n:
                progress += 1
            else:
                pass

        if progress == len_files:
            missing_folders.append(n)

    if len(missing_folders) == 0:
        pass

    else:
        print('En el directorio {} faltan las carpetas: '.format(route_downloads))

        for c in missing_folders:
            print('* {}'.format(c))

        try:
            for mf in missing_folders:
                # OJO AQUÍ CON LA SITAXIS DE LA RUTA
                os.mkdir(route_downloads + mf)
                
            print('Carpetas creadas.')
        except:
            print('Oh, ah ocurrido un error inesperado.')


def order(file, extension):

    for etx in text_extensions:

        if extension == etx:
            shutil.move(route_downloads + file, route_downloads + 'Texto')
        
    for etx in excel_extensions:

        if extension == etx:
            shutil.move(route_downloads + file, route_downloads + 'Excel')

    for etx in pdf_extensions:

        if extension == etx:
            shutil.move(route_downloads + file, route_downloads + 'PDF')

    for etx in torrent_extensions:

        if extension == etx:
            shutil.move(route_downloads + file, route_downloads + 'Torrents')

    for etx in imagen_extensions:

        if extension == etx:
            shutil.move(route_downloads + file, route_downloads + 'ISO')

    for etx in video_extensions:

        if extension == etx:
            shutil.move(route_downloads + file, route_downloads + 'Video')

    for etx in audio_extensions:

        if extension == etx:
            shutil.move(route_downloads + file, route_downloads + 'Sonido')

    for etx in photo_extensions:

        if extension == etx:
            shutil.move(route_downloads + file, route_downloads + 'Imagenes')

    for etx in compressed_extensions:

        if extension == etx:
            shutil.move(route_downloads + file, route_downloads + 'Comprimidos')

    for etx in executable_extensions:

        if extension == etx:
            shutil.move(route_downloads + file, route_downloads + 'Programas')

    if extension != '':
        try:
            shutil.move(route_downloads + file, route_downloads + 'Otros')

        except:
            pass

    
def main():

    check_folders()

    for file in os.listdir(route_downloads):

        try:
            etx = os.path.splitext(file)[1]

            order(file, etx)

        except:
            print('No se puedo mover el archivo {}\n'.format(file))

    print('Proceso terminado')


if __name__ == '__main__':
    main()