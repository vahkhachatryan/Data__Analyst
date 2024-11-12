
# Web Scraping Project

This project involves web scraping data from **eBay** to gather information about **phones**. It uses Python scripts to extract links, save them in JSON format, fetch item details, and store data in structured formats for further analysis.

## Project Structure

Here’s an overview of the main files in this project:

1. **`links_Save_Json.py`** - A script to save the initial links for phone listings in a JSON file.
2. **`Scrap_Short_link.py`** - Processes shortened links to get full details.
3. **`about_item.py`** - Extracts detailed information about each item based on the collected links.
4. **`final_code.ipynb`** - A Jupyter Notebook for scraping item reviews with AI assistance and saving results in an Excel file.
5. **Output Files**:
   - **`phone_info.xlsx`**: Contains structured phone information gathered from the scraping process.
   - **`reviews_with_clipped.xlsx`**: Contains reviews related to each item for further analysis.

## Requirements

To run this project, you will need the following Python libraries:

- **requests**: For making HTTP requests to fetch webpage data.
- **BeautifulSoup (bs4)**: For parsing HTML and extracting data.
- **json**: For handling JSON data when saving links and other metadata.
- **pandas**: For data manipulation and saving data to Excel.
- **jupyter**: To run the Jupyter Notebook.

Install the dependencies using:

```bash
pip install requests beautifulsoup4 pandas jupyter
```

## Set Up API Keys (if applicable)

If you are using any external APIs, such as the OpenAI API for AI-generated content in reviews, ensure you have set up your API keys correctly.

1. **Obtain the API Key**: Sign up on the [OpenAI website](https://openai.com/) or the relevant API provider’s site to obtain an API key.
2. **Add the Key to Your Environment**: It is recommended to add your API key as an environment variable to keep it secure.

   On Linux/macOS, use:
   ```bash
   export OPENAI_API_KEY='your_api_key_here'
   ```

   On Windows, use:
   ```bash
   set OPENAI_API_KEY='your_api_key_here'
   ```

3. **Access the Key in Your Code**: In your scripts or notebook, access the API key like this:

   ```python
   import os
   api_key = os.getenv('OPENAI_API_KEY')
   ```

> **Note:** Avoid hardcoding API keys directly in your code to maintain security. If an API key is accidentally committed to Git, remove it immediately from your Git history and re-push your changes.

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
   Run `about_item.py` to scrape detailed information for each item, saving results in the Excel files (`phone_info.xlsx` and `reviews_with_clipped.xlsx`).

   ```bash
   python about_item.py
   ```

4. **Get Item Reviews with AI**:
   Open `final_code.ipynb` in Jupyter Notebook to scrape detailed information and reviews for each item. The results will be saved in an Excel file (`phone_info (1).csv`).

   To run the notebook:

   ```bash
   jupyter notebook final_code.ipynb
   ```

## Output

- **`phone_info.xlsx`**: Contains primary details about each phone, such as model, price, and specifications.
- **`reviews_with_clipped.xlsx`**: Includes reviews scraped for each item, if available.
- **`phone_info (1).csv`**: Additional detailed information and reviews saved from `final_code.ipynb`.

## Notes

- Ensure you have the correct permissions to scrape data from the website.
- Data scraping should be performed responsibly to avoid excessive load on the website.

## License

This project is licensed under the MIT License.

---

This `README.md` now includes a section on **Set Up API Keys**, explaining how to handle and access API keys securely.