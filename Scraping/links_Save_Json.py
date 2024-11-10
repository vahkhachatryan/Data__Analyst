import pandas as pd
import re
import json

# Load the CSV file into a pandas DataFrame
df = pd.read_csv('Link_ebay_scraped_data.csv')

# Strip whitespace from column names if necessary
df.columns = df.columns.str.strip()

# Use the correct column name 'Link' based on the CSV file
if 'Link' not in df.columns:
    print(f"Columns in the CSV: {df.columns}")
    raise ValueError("The 'Link' column does not exist. Please check the column name.")

# Initialize an array to store the item numbers
item_numbers = []

# Loop through the 'Link' column in the DataFrame
for index, row in df.iterrows():
    link = row['Link']
    
    # Extract the item number using a regular expression
    match = re.search(r'/itm/(\d+)', link)
    if match:
        item_number = match.group(1)
        item_numbers.append(item_number)
    else:
        print(f"Item number not found in link: {link}")

# Save the array to a .txt file
with open('item_numbers.txt', 'w') as f:
    f.write(','.join(item_numbers))

# Alternatively, save the array to a .json file
with open('item_numbers.json', 'w') as f:
    json.dump(item_numbers, f)

print(f"{len(item_numbers)} item numbers have been extracted and saved.")

