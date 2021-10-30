import sqlite3
from datetime import date
import os
from cryptography.fernet import Fernet

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

def write_key():
    key = Fernet.generate_key() 
    with open("key.key", "wb") as key_file: 
        key_file.write(key) 

#write_key()

Fkey=buscarArchivo("key.key")  
BBDD=buscarArchivo("mydatabase.db") 
        
def decrypt(encrypted_message): 
    key = open(Fkey, "rb").read() 
    f = Fernet(key)
    
    decrypted_message = f.decrypt(encrypted_message)
    return decrypted_message.decode()
    
def encrypt(message):
    key = open(Fkey, "rb").read()
    f = Fernet(key)
    msg=message.encode()
    encrypted_message = f.encrypt(msg)
    return encrypted_message

conexion = sqlite3.connect(BBDD)
cursor = conexion.cursor()

def login(usuario, contraseña):
    os.system("clear")
    
    listacontraseñas = []
    cursor.execute("SELECT contraseña FROM usuarios")
    rows = cursor.fetchall()

    encontrado = 0;
    for row in rows:
        listacontraseñas.append(row)
        for contra in listacontraseñas:
            if contraseña == decrypt(contra[0]) :
                encontrado=1
            
    if encontrado == 1:
        cursor.execute('SELECT * FROM usuarios WHERE Usuario = ? AND contraseña = ?', (usuario, contra[0]))
        if cursor.fetchall():
            print("Usuario o contraseña correcta")
            return True
        else:
            print("Usuario o contraseña incorrecta")
            exit()
    else:
            print("Usuario o contraseña incorrecta")
            exit()

def crearbbdd():
    nombre = input("Introduce el nombre de la base de datos \n")
    try:
        cursor.execute("CREATE TABLE {} (id integer PRIMARY KEY, name text, salary real, department text, position text, hireDate text)".format(nombre))
    except sqlite3.OperationalError:
        print("La tabla ya existe")

    conexion.commit()
    
def Añadir(entities):
    cursor.execute('INSERT INTO employees(id, name, salary, department, position, hireDate) VALUES(?, ?, ?, ?, ?, ?)', entities)
    conexion.commit()

def AñadirUsuarios(entities):
    cursor.execute('INSERT INTO Usuarios(id, Usuario, Contraseña) VALUES(?, ?, ?)', entities)
    conexion.commit()
    
def actualizar():
    cursor.execute('UPDATE employees SET name = "Angel" where name = "Andres"')
    conexion.commit()
 
def eliminarfilaporID(id):
    cursor.execute('delete FROM employees where id = ?', (id,))
    conexion.commit()   

def obtenerdatos():
    lista = []
    cursor.execute("SELECT * FROM {}".format("employees"))
    rows = cursor.fetchall()

    for row in rows:
        lista.append(row)
    
    return lista

def obtenerdatospornombre(nombre):
    lista = []
    cursor.execute("SELECT * FROM employees WHERE name = ?", (nombre,))
    rows = cursor.fetchall()

    for row in rows:
        lista.append(row)
    
    return lista
 
def imprimirfilas(lista):
    os.system('cls')
    for i in range(len(lista)):
        print(lista[i])
    
#sql_insert(conexion, entities)
#sql_update(conexion)
#eliminarfila(conexion)
#lista = obtenerdatos(conexion)


# cursor.execute('SELECT * FROM employees')
# numero = (len(cursor.fetchall()))

# nombre = "Andres"

# for num in range(numero):
#     for num2 in range(numero):
#         if lista[num][num2] == nombre:
#             print(lista[num][num2])
#             exit



print("Introduce usuario y contrasña para iniciar sesion: ")
usuario = input("Usuario: \n")
contraseña = input("Contraseña: \n")
login(usuario,contraseña)

nuevo=input("Quieres añadir un nuevo usuario? (s) o (n) \n")
if nuevo == "s" or nuevo == "si":
    id=input("ID? \n")
    usuario=input("Nombre de usuario? \n")
    contraseñaclaro=input("Contraseña? \n")
    contraseña=encrypt(contraseñaclaro)
    entities = (id, usuario, contraseña)
    AñadirUsuarios(entities)

nuevat=input("Quieres añadir una nueva tabla? (s) o (n) \n")
if nuevat == "s" or nuevat == "si":
    crearbbdd()

nueva=input("Quieres añadir una fila nueva? (s) o (n) \n")
if nueva == "s" or nueva == "si":
    id=input("ID? \n")
    Nombre=input("Nombre? \n")
    Sueldo=input("Sueldo? \n")
    fechahoy=date.today()
    entities = (id, Nombre, Sueldo, 'lopez', 'prueba', fechahoy)
    Añadir(entities)

filas=input("Quieres mostrar todos las filas que hay? \n")
if filas == "s" or filas == "si":
    lista = obtenerdatos()
    imprimirfilas(lista)

filas=input("Quieres buscar por nombre? \n")
if filas == "s" or filas == "si":
    lista = obtenerdatospornombre(usuario)
    if len(lista) > 0:
        imprimirfilas(lista)
    else:
        print("No existe el usuario {} en la base de datos".format(usuario))

filas=input("Quieres eliminar a alguien? \n")
if filas == "s" or filas == "si":
    id = input("Introduce su ID: ")
    eliminarfilaporID(id)
    lista = obtenerdatos()
    imprimirfilas(lista)

conexion.close()