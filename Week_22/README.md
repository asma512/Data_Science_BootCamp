
1.Create a python function to scrape Yelp data for 50 restaurants close to you OR Craigslist for the top 50 items of any topic interesting to you. Think about what data you want to scrape aside from the name and location. You must pick at least three other fields. You can use beautiful soup, selenium, scrapy, and/or splinter as possible.

I created a python function to scrape Craigslist data for top 50 apt/ housing in Boston. The beautiful soup module was used to find the list of all the listings. There are 120 lisiting per page. I only used the first 50 items on the first page.I scraped the posting's time, neighborhood, description, prices, and link.

Code: craigslist_scrape.py

2.	Create a local API that calls your scrape function and stores the data when you call /scrape endpoint. The data you scrape should be viewable when you go to /all .
3.	
Code: craigslist_api.py, templates folder

I imported the the function from the previous question to display the data.

Homepage:

<img width="400" alt="Screen Shot 2022-03-02 at 8 48 49 PM" src="https://user-images.githubusercontent.com/20906514/156480725-ef137383-9fcb-41b6-9de4-3c6ecbbcfa36.png">
/scrape:

<img width="1213" alt="Screen Shot 2022-03-02 at 8 55 41 PM" src="https://user-images.githubusercontent.com/20906514/156481391-2f55c285-77ed-45d9-a3ea-2005ff64ab79.png">
/scrape/all:

<img width="1213" alt="Screen Shot 2022-03-02 at 8 58 50 PM" src="https://user-images.githubusercontent.com/20906514/156481724-00c218f8-9530-45de-b35e-0c0f7ea65943.png">
3.	What is web scraping? Why is it helpful? What does it mean for your online presence?
Refence the readings and DataCamp. 
<img width="592" alt="Screen Shot 2022-03-02 at 11 43 34 PM" src="https://user-images.githubusercontent.com/20906514/156497765-316cdcce-abc3-40b3-b2e4-178d9ad90311.png">
