import pandas as pd
import re
import json

df = pd.read_csv('Link_ebay_scraped_data.csv')

df.columns = df.columns.str.strip()

if 'Link' not in df.columns:
    print(f"Columns in the CSV: {df.columns}")
    raise ValueError("The 'Link' column does not exist. Please check the column name.")

item_numbers = []

for index, row in df.iterrows():
    link = row['Link']
    
    match = re.search(r'/itm/(\d+)', link)
    if match:
        item_number = match.group(1)
        item_numbers.append(item_number)
    else:
        print(f"Item number not found in link: {link}")

with open('item_numbers.txt', 'w') as f:
    f.write(','.join(item_numbers))

with open('item_numbers.json', 'w') as f:
    json.dump(item_numbers, f)

print(f"{len(item_numbers)} item numbers have been extracted and saved.")

