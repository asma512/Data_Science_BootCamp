from flask import Flask, render_template
from flask_pymongo import PyMongo
import datetime


app = Flask(__name__)

#setup mongo connection with database
app.config['MONGO_URI']="mongodb://localhost:27017/shows_db"
mongo = PyMongo(app)

#connect to collection
tv_shows = mongo.db.tv_shows

#READ
@app.route("/")
def index():
    #find all items in db and save to a variable
    all_shows = list(tv_shows.find())

    return render_template('index.html',data=all_shows)

@app.route("/insert")
def insert():
    show_one = {'name': "Grey's Anatomy",
                'seasons': 18,
                'duration': '43 minutes',
                'year': 2005,
                'date_added':datetime.datetime.utcnow()
                }
    show_two = {'name': "How to Get Away with a Murderer",
                'seasons': 6,
                'duration': '43 minutes',
                'year': 2013,
                'date_added':datetime.datetime.utcnow()
                }
    tv_shows.insert_one(show_one)
    tv_shows.insert_one(show_two)
    index()
#UPDATE
@app.route("/update")
def update():
    item = {'name': 'How to Get Away with a Murderer'}

    updated_value= { "$set": { 'year': 2014 } }

    tv_shows.update_one(item,updated_value)

    

@app.route("/delete")
def delete():
    tv_shows.delete_one({'name': 'How to Get Away with a Murderer'})
    tv_shows.delete_one({'name': "Grey's Anatomy"})
    return index()

if __name__ == "__main__":
    app.run(debug=True)
