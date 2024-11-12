from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import pandas as pd
import json
import time

# Set up Selenium and ChromeDriver
chrome_options = Options()
chrome_options.add_argument("--no-sandbox")
chrome_options.add_argument("--disable-dev-shm-usage")
# chrome_options.add_argument("--headless")  # Uncomment to run headless

# Path to ChromeDriver
driver_path = "/usr/bin/chromedriver"
service = Service(driver_path)

# Initialize WebDriver
driver = webdriver.Chrome(service=service, options=chrome_options)

# Load the item IDs from the JSON file
with open('item_numbers.json', 'r') as f:
    item_ids = json.load(f)

# Base URL pattern
base_url = "https://www.ebay.com/itm/"

# List to store scraped data
scraped_data = []

for item_id in item_ids:
    # Create dynamic link
    link = f"{base_url}{item_id}"
    print(f"Opening link: {link}")
    driver.get(link)

    # Wait for the page to load
    try:
        WebDriverWait(driver, 20).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, ".x-item-title__mainTitle"))
        )
        print(f"Page loaded successfully: {link}")

        # Get the item title
        try:
            title_element = driver.find_element(By.CSS_SELECTOR, ".x-item-title__mainTitle")
            title = title_element.text
        except Exception as e:
            print(f"Error finding title: {e}")
            title = 'No title found'

        # Scroll down the page to load all content
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(3)

        # Initialize variables for other data
        model, storage_capacity, ram, operating_system, camera_resolution, connectivity, price = 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A'

        # Wait for the specifications section to load (if present)
        try:
            WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.CLASS_NAME, "ux-layout-section-evo__row"))
            )

            rows = driver.find_elements(By.CLASS_NAME, "ux-layout-section-evo__row")
            for row in rows:
                label = row.find_element(By.CLASS_NAME, "ux-labels-values__labels").text
                value = row.find_element(By.CLASS_NAME, "ux-labels-values__values").text

                # Print for debugging what is found
                print(f"Label: {label}, Value: {value}")

                # Assign the scraped data to the right variable based on the label
                if "Model" in label:
                    model = value
                elif "Storage Capacity" in label:
                    storage_capacity = value
                elif "RAM" in label:
                    ram = value
                elif "Operating System" in label:
                    operating_system = value
                elif "Camera Resolution" in label:
                    camera_resolution = value
                elif "Connectivity" in label:
                    connectivity = value

        except Exception as e:
            print(f"Error scraping specifications for {item_id}: {e}")

        # Attempt to scrape the price using multiple approaches
        try:
            # Most common price format
            price_element = driver.find_element(By.CSS_SELECTOR, ".x-price-whole")
            price_fraction_element = driver.find_element(By.CSS_SELECTOR, ".x-price-fraction")
            price = price_element.text + "." + price_fraction_element.text
        except Exception as e:
            print(f"Error finding price in regular format: {e}")
            try:
                # Try discount or alternate price formats
                price_element = driver.find_element(By.CSS_SELECTOR, ".x-price-discount")
                price = price_element.text
            except Exception as e:
                print(f"Error finding price in discount format: {e}")
                try:
                    # Fallback to yet another price format
                    price_element = driver.find_element(By.CSS_SELECTOR, ".x-price-offer")
                    price = price_element.text
                except Exception as e:
                    print(f"Error finding price in offer format: {e}")
                    price = 'No price found'

        # Append data to list
        scraped_data.append({
            'Item ID': item_id,
            'Title': title,
            'Model': model,
            'Storage Capacity': storage_capacity,
            'RAM': ram,
            'Operating System': operating_system,
            'Camera Resolution': camera_resolution,
            'Connectivity': connectivity,
            'Price': price
        })

    except Exception as e:
        print(f"Error loading item page for {item_id}: {e}")

# Close the browser
driver.quit()

# Convert the list of dictionaries to a DataFrame
df = pd.DataFrame(scraped_data)

# Save the data to a CSV file with the correct column names
csv_file_name = 'about_item.csv'
df.to_csv(csv_file_name, index=False, encoding='utf-8')

print(f"Scraping completed and data saved to {csv_file_name}")

