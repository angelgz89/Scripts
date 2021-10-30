#!/usr/bin/python
# -*- coding: utf-8 -*-
# www.pythondiario.com

from tkinter import *
from tkinter import messagebox
import sqlite3

# Connect to database
db = sqlite3.connect('mydatabase.db')
c = db.cursor()

ventana = Tk()
ventana.title ("------- Login Python -------")
ventana.geometry ('300x300')
frame1 = Frame(ventana)
frame1.grid(row=0,column=0,sticky='nsew')


Lusuario = Label(frame1, text = "Usuario:")
caja1 = Entry(frame1)
Lusuario.grid(padx=10,pady=10)
caja1.grid(padx=10,pady=10)

Lcontraseña = Label(frame1, text = "Contraseña:")
caja2 = Entry(frame1, show = "*")
Lcontraseña.grid(padx=10,pady=10)
caja2.grid(padx=10,pady=10)

def obtenerdatos():
    lista = []
    c.execute("SELECT name FROM employees WHERE name = ?", (caja1.get(),))
    rows = c.fetchall()

    for row in rows:
        lista.append(row)
    
    return lista

def login():
	
	usuario = caja1.get()
	contraseña = caja2.get()
	
	c.execute('SELECT * FROM usuarios WHERE Usuario = ? AND contraseña = ?', (usuario, contraseña))
	
	if c.fetchall():
		messagebox.showinfo(title = "Login correcto", message = "Usuario y contraseña correctos")
		lista=obtenerdatos()
		frame2 = Frame(ventana)
		frame2.grid(row=0,column=0,sticky='nsew')
		if len(lista) > 0:
			prueba = Label(frame2, text = "Hola " + str(lista[0][0]))
			prueba.grid(padx=10,pady=10)
		else:
			prueba = Label(frame2, text = "Hola desconocido")
			prueba.grid(padx=10,pady=10)
	else:
		messagebox.showerror(title = "Login incorrecto", message = "Usuario o contraseña incorrecta")
		
	c.close()

btn = Button(frame1, text = "Login", command = login)
btn.grid(padx=10,pady=10)

ventana.mainloop()