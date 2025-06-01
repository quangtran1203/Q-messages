from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home_page(): # Renaming to home_page is optional but perhaps more descriptive
    return render_template('index.html')
