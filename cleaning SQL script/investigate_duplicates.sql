


-- ^This joins calendar c1 with calendar. It inner joins them on

/*
-- check for duplicates:
SELECT listing_id, date_formatted, COUNT(*) 
FROM calendar 
GROUP BY listing_id, date_formatted 
HAVING COUNT(*) > 1 
ORDER BY listing_id, date_formatted
LIMIT 0, 1000
*/

/*
ALTER TABLE calendar
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
-- ^Add a unique id to make it easier to delete duplicates.
*/