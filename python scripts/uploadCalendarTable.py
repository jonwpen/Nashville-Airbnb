import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.exc import SQLAlchemyError
import logging

# Setup logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Database connection using SQLAlchemy
engine = create_engine('mysql+mysqlconnector://{user}:{password}@localhost:3306/nashville_airbnb', pool_pre_ping=True)

try:
    # Load the calendar CSV file into a DataFrame
    calendar_path = '/Users/johnpennington/Desktop/Data Analysis/Projects/airbnb project/airbnb nashville data/calendar.csv'
    df_calendar = pd.read_csv(calendar_path)
    logging.info("Calendar data loaded successfully.")
    print(df_calendar.head())

    # Using a transaction block to ensure all or nothing commits
    with engine.begin() as conn:
        df_calendar.to_sql(name='calendar', con=conn, if_exists='replace', index=False, chunksize=5000)
        logging.info("Calendar table replaced successfully in the database.")

except SQLAlchemyError as e:
    logging.error(f"An error occurred: {e}")
    # Roll back any changes if an exception occurs
    conn.rollback()
    raise

finally:
    # Close the database connection
    engine.dispose()
    logging.info("Database connection closed.")
