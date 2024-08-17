# Random Data Generator

This project generates a CSV file containing random user data, including user IDs, names, and ages.

## Features
- Generates a configurable number of random user records
- Outputs the data to a CSV file
- Option to run locally or within a Docker container

## Prerequisites

Before you begin, ensure you have the following installed:
- Python 3.10 or higher
- Docker (optional, if you want to run the project in a container)

## Installation

### Option 1: Run Locally

1. **Clone the repository**:

   ```bash
   git clone git@github.com:vahkhachatryan/Data__Analyst.git
   cd Docker_project
   ```

2. **Install the dependencies**:

   ```bash
   pip install -r requirements.txt
   ```

3. **Run the script**:

   ```bash
   python3 main.py
   ```

### Option 2: Run with Docker

1. **Build the Docker image**:

   ```bash
   docker build -t main .
   ```

2. **Run the Docker container**:

   ```bash
   docker run --rm main
   ```

