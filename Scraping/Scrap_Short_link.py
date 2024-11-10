from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from bs4 import BeautifulSoup
import pandas as pd
import time
import re  # Import regular expressions module

# Set up Selenium and open the page
options = webdriver.ChromeOptions()
options.add_argument('--headless')  # Run browser in headless mode
service = Service('/usr/bin/chromedriver')  # Corrected for service
driver = webdriver.Chrome(service=service, options=options)

url = 'https://www.ebay.com/b/Cell-Phones-Smartphones/9355/bn_320094'
driver.get(url)

# Allow the page to load
time.sleep(3)

# Get the page source and pass it to BeautifulSoup
soup = BeautifulSoup(driver.page_source, 'html.parser')
driver.quit()  # Close the browser after getting the page source

# Scrape the first 10 items
items = soup.find_all('li', class_='s-item', limit=10)

data = []
for item in items:
    title = item.find('h3', class_='s-item__title')
    price = item.find('span', class_='s-item__price')
    link = item.find('a', class_='s-item__link')['href']

    # Extract the item number using a regular expression
    match = re.search(r'/itm/(\d+)', link)
    if match:
        clean_link = f'https://www.ebay.com/itm/{match.group(1)}'  # Extract the dynamic item number
    
    # Check if title and price exist to avoid NoneType errors
    if title and price and match:
        data.append({
            'Title': title.text,
            'Price': price.text,
            'Link': clean_link
        })

# Save the data into a CSV file
df = pd.DataFrame(data)
df.to_csv('Link_ebay_scraped_data.csv', index=False)

print("Scraping completed and data saved to Link_ebay_scraped_data.csv")

