# Web Scraping Project

This project involves web scraping data from **eBay** to gather information about **phones**. It uses Python scripts to extract links, save them in JSON format, fetch item details, and store data in structured formats for further analysis.

## Project Structure

Here’s an overview of the main files in this project:

1. **`links_Save_Json.py`** - A script to save the initial links for phone listings in a JSON file.
2. **`Scrap_Short_link.py`** - Processes shortened links to get full details.
3. **`about_item.py`** - Extracts detailed information about each item based on the collected links.
4. **`phone_info.xlsx`** - An Excel file containing the structured phone information gathered from the scraping process.
5. **`reviews_with_clipped.xlsx`** - Contains reviews related to each item, extracted and saved for analysis.

## Requirements

To run this project, you will need the following Python libraries:

- **Requests**: For making HTTP requests to fetch webpage data.
- **BeautifulSoup (bs4)**: For parsing HTML and extracting data.
- **JSON**: To handle JSON data when saving links and other metadata.
- **Pandas**: For data manipulation and saving data to Excel.

Install the dependencies using:

```bash
pip install requests beautifulsoup4 pandas
```

## Usage

1. **Save Links**:
   Run `links_Save_Json.py` to collect and save item links in JSON format.
   
   ```bash
   python links_Save_Json.py
   ```

2. **Process Short Links**:
   Use `Scrap_Short_link.py` to process shortened URLs and prepare them for detailed extraction.

   ```bash
   python Scrap_Short_link.py
   ```

3. **Get Item Details**:
   Finally, run `about_item.py` to scrape detailed information for each item, saving results in the Excel files (`phone_info.xlsx` and `reviews_with_clipped.xlsx`).

   ```bash
   python about_item.py
   ```

## Output

- **`phone_info.xlsx`**: Contains the primary details about each phone, such as model, price, and specifications.
- **`reviews_with_clipped.xlsx`**: Includes reviews scraped for each item, if available.

## Notes

- Ensure you have the correct permissions to scrape data from the website.
- Data scraping should be performed responsibly to avoid excessive load on the website.

## License

This project is licensed under the MIT License.

---

