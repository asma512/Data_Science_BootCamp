import requests
from requests import get
from bs4 import BeautifulSoup
import re
from warnings import warn
from time import time
import numpy as np
import pandas as pd

def craigslist_scrape():
    response = get('https://boston.craigslist.org/search/apa?hasPic=1&max_price=2000&availabilityMode=0')
    soup = BeautifulSoup(response.text, 'html.parser')
    postings = soup.find_all('li', class_= 'result-row')
    timing = []
    neighborhood = []
    title_texts = []
    links = []
    prices = []
    for i in range(50):
        listing = postings[i]
        if listing.find('span', class_ = 'result-hood') is not None:

            listing_datetime = listing.find('time', class_= 'result-date')['datetime']
            timing.append(listing_datetime)


            listing_neighbor = listing.find('span', class_= 'result-hood').text
            neighborhood.append(listing_neighbor.replace("(","").replace(")",""))


            listing_title = listing.find('a', class_='result-title hdrlnk')
            listing_title_text = listing_title.text
            title_texts.append(listing_title_text)


            listing_link = listing_title['href']
            links.append(listing_link)
            

            listing_price = listing.a.text.strip().replace("$", "") 
            prices.append(listing_price)


    boston_apts = pd.DataFrame({'time': timing,
                            'neighborhood': neighborhood,
                        'list title': title_texts,
                            'price': prices,
                            'URL': links
                        })

    return boston_apts

craigslist_scrape()