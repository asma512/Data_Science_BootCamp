from flask import Flask, render_template
import pandas as pd
from craigslist_scrape import craigslist_scrape

app = Flask(__name__)

@app.route("/")
def base():
    return render_template('home.html')

@app.route("/scrape")
def scrape():
    data = craigslist_scrape()
    df = pd.DataFrame.to_dict(data)
    return render_template('scrape.html', data=df)


@app.route("/scrape/all")
def all():
    data = craigslist_scrape()
    return data.to_html(header="true",table_id="table")

if __name__ == "__main__":
  app.run(debug=True)