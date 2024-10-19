SELECT 
    SUM(CASE WHEN available = 'f' THEN 1 ELSE 0 END) AS booked_count,
    SUM(CASE WHEN available = 't' THEN 1 ELSE 0 END) AS available_count,
    YEAR(date_formatted) AS year,  -- Group by year
    MONTH(date_formatted) AS month,  -- Group by month
    (SUM(CASE WHEN available = 'f' THEN 1 ELSE 0 END) * 100.0) / 
	(SUM(CASE WHEN available = 'f' THEN 1 ELSE 0 END) + SUM(CASE WHEN available = 't' THEN 1 ELSE 0 END)) AS occupancy_rate
FROM 
    calendar_cleaned
GROUP BY 
    YEAR(date_formatted),  -- Group by year
    MONTH(date_formatted)  -- Group by month
ORDER BY 
    year,  -- Sort by year
    month;  -- Sort by month within the year

-- ^Find availability and occupancy rates.


 
/*
SELECT AVG(price) AS avg_price, MONTH(date_formatted)
FROM calendar_cleaned
GROUP BY MONTH(date_formatted)
ORDER BY MONTH(date_formatted)
*/

/*
SELECT SUM(price), listing_id
FROM calendar_cleaned
GROUP BY listing_id
ORDER BY listing_id
*/