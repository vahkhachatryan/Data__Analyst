import csv
import random
from faker import Faker

# Configuration
num_rows = 100  # Number of rows of data
output_file = 'random_data.csv'  # Output CSV file name

# Column headers
headers = ['user_id', 'full_name', 'age']

# Initialize Faker
fake = Faker()

# Generate the CSV data and print it
with open(output_file, mode='w', newline='') as file:
    writer = csv.writer(file)
    
    # Write the headers and print them
    writer.writerow(headers)
    print(headers)  # Print the headers to the console
    
    # Write the data rows and print them
    for user_id in range(1, num_rows + 1):
        name = fake.name()  # Generate a random name using Faker
        age = random.randint(18, 99)  # Age between 18 and 99
        row = [user_id, name, age]
        writer.writerow(row)
        print(row)  # Print each row to the console

print(f"CSV file '{output_file}' with {num_rows} rows has been generated.")

