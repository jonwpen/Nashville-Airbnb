import geopandas as gpd
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError
import logging

class GeoJSONUploader:
    def __init__(self, db_connection_string):
        self.engine = create_engine(db_connection_string, pool_pre_ping=True)
        logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

    def load_geojson(self, file_path):
        try:
            self.gdf = gpd.read_file(file_path)
            logging.info(f"GeoJSON data loaded successfully from {file_path}")
        except Exception as e:
            logging.error(f"Failed to load GeoJSON data from {file_path}: {e}")
            raise

    def upload_data(self, table_name):
        try:
            with self.engine.begin() as conn:
                # Drop the existing table if it exists and create a new one
                conn.execute(text(f"DROP TABLE IF EXISTS {table_name};"))
                conn.execute(text(f"""
                    CREATE TABLE {table_name} (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        geom MULTIPOLYGON
                    );
                """))
                # Insert geometry data into the table
                for _, row in self.gdf.iterrows():
                    conn.execute(
                        text(f"INSERT INTO {table_name} (geom) VALUES (ST_GeomFromText(:geom, 4326));"),
                        {'geom': row['geometry'].wkt}
                    )
                logging.info(f'{table_name} table created and data uploaded successfully.')
        except SQLAlchemyError as e:
            logging.error(f"An error occurred during SQL operations: {e}")
            raise
        finally:
            self.engine.dispose()


# Usage
if __name__ == "__main__":
    uploader = GeoJSONUploader("mysql+mysqlconnector://{user}:{password}@localhost:3306/nashville_airbnb")
    geojson_path = "/Users/johnpennington/Desktop/Data Analysis/Projects/airbnb project/airbnb nashville data/neighbourhoods.geojson"
    uploader.load_geojson(geojson_path)
    uploader.upload_data("neighborhoods")
