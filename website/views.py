from flask import Blueprint, render_template

views = Blueprint('views', __name__)

@views.route('/')
def home():
    return render_template("home.html")

@views.route('/Organismos')
def Organismos():
    return render_template("Organismos.html")
