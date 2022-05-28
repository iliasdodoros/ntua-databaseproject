from dataclasses import field, fields
from datetime import date
from flask import Blueprint, render_template, request
import mysql.connector

ourdb = mysql.connector.connect(
    host="localhost", user="root", password="", database="elidek")


mycursor = ourdb.cursor()
datau = mycursor.execute("SELECT * FROM Programm")
mytable = mycursor.fetchall()

views = Blueprint('views', __name__)


@views.route('/')
def home():
    return render_template("home.html")


@views.route('/Organismos', methods=['GET', 'POST'])
def Organismos():
    if request.method == 'POST':
        data = request.form["i"]
        lost = mycursor.execute(f'SELECT * FROM {data}')
        table = mycursor.fetchall()
        # listed = list(table)
        return render_template("Organismos.html", table=table, boolean=True)

    return render_template("Organismos.html", boolean=True)


@views.route('/Stelehos')
def Stelehos():
   
    return render_template("Stelehos.html",)


@views.route('/Programm')
def Researcher():
    found = mycursor.execute('SELECT * FROM Stelehos')
    researchers = mycursor.fetchall()
    vlaka = mycursor.execute('SELECT * FROM Research_Field')
    fields = mycursor.fetchall()
    return render_template("Programm.html",researchers=researchers,fields=fields)
    


@views.route('/Research_Field')
def Research_Field():
    lost = mycursor.execute('SELECT * FROM Research_Field')
    fields = mycursor.fetchall()
    return render_template("Research_Field.html",fields=fields)
