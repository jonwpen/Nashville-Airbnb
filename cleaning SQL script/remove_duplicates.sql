DELETE l
FROM listings l
LEFT JOIN (
    SELECT MIN(uic) AS uic
    FROM listings
    GROUP BY id
) AS keepers ON l.uic = keepers.uic
WHERE keepers.uic IS NULL;


/*
Create a new test table by create a new table, then inserting 'SELECT * FROM original_table.
A straightforward way to delete duplicates and retain each unique entry:
For this table, all data is identical where the id is repeated.
So, create an auto-incremented 'new id'. Then delete all rows for each id where the 'new id' is the minimum.
Use a JOIN approach:
A derived table 'keeper' is created to find the min uic for each id.
The main table is left joined to keeper.
Rows where keeper.uic is NULL are deleted.
*/

-- STEP 1
-- ALTER TABLE listings_test
-- ADD COLUMN uic INT AUTO_INCREMENT PRIMARY KEY;

-- STEP 2
/*
DELETE l
FROM listings_test l
LEFT JOIN (
    SELECT MIN(uic) AS uic
    FROM listings_test
    GROUP BY id
) AS keepers ON l.uic = keepers.uic
WHERE keepers.uic IS NULL;
*/