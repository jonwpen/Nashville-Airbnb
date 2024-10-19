import logging
from sqlalchemy import create_engine
import pandas as pd

# Setup logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Create a connection to your MySQL database with an increased timeout
engine = create_engine(
    'mysql+mysqlconnector://{user}:{password}@localhost:3306/nashville_airbnb',
    connect_args={'connect_timeout': 10000}
)

try:
    # Load data from the calendar table into a DataFrame
    logging.info("Loading data from the database.")
    df = pd.read_sql('SELECT * FROM calendar', engine)

    # Keep the lowest 'id' for each group
    logging.info("Cleaning duplicates from the data.")
    df_cleaned = df.sort_values('id').drop_duplicates(subset=['listing_id', 'date_formatted'], keep='first')

    # Using a transaction block to ensure all or nothing commits
    with engine.begin() as connection:
        logging.info("Starting to write cleaned data back to the database.")
        df_cleaned.to_sql('calendar_cleaned', con=connection, if_exists='replace', index=False, chunksize=10000)
        logging.info("Data successfully written to database.")

except Exception as e:
    logging.error(f"An error occurred: {e}")

finally:
    # Close the SQLAlchemy engine connection
    engine.dispose()
    logging.info("Database connection closed.")
