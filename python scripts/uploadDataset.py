import pandas as pd
import os
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError
import logging

# Setting up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Engine for all SQLAlchemy operations
engine = create_engine('mysql+mysqlconnector://{user}:{password}@localhost:3306/nashville_airbnb', pool_pre_ping=True)

try:
    # Load and print CSV file for 'calendar.csv'
    df_calendar = pd.read_csv('/Users/johnpennington/Desktop/Data Analysis/Projects/airbnb project/airbnb nashville data/calendar.csv')
    logging.info("Calendar data loaded successfully")
    print(df_calendar.head())

    # Write CSV data to MySQL in batches
    chunk_size = 10000
    for start in range(0, df_calendar.shape[0], chunk_size):
        end = start + chunk_size
        batch = df_calendar.iloc[start:end]
        with engine.begin() as conn:
            batch.to_sql(name='calendar', con=conn, if_exists='append', index=False)
        logging.info(f"Batch from {start} to {end} uploaded successfully")

    # Directory where your CSV files are stored
    csv_directory = '/Users/johnpennington/Desktop/Data Analysis/Projects/airbnb project/airbnb nashville data'

    # Process all CSV files within a transaction for each file
    for file_name in os.listdir(csv_directory):
        if file_name.endswith('.csv') and file_name != 'calendar.csv':  # Ensure not to reprocess 'calendar.csv'
            file_path = os.path.join(csv_directory, file_name)
            df = pd.read_csv(file_path)
            # Perform batch processing for each file
            for start in range(0, df.shape[0], chunk_size):
                end = start + chunk_size
                batch = df.iloc[start:end]
                with engine.begin() as conn:
                    batch.to_sql(name=file_name[:-4], con=conn, if_exists='append', index=False)
                logging.info(f"Batch from {start} to {end} in {file_name} uploaded successfully")

except SQLAlchemyError as e:
    logging.error(f"An error occurred during SQL operations: {e}")
    raise  # Optionally re-raise the error for further handling or logging
finally:
    # Close the SQLAlchemy engine connection
    engine.dispose()
    logging.info("Database connection closed.")
