-- Calculate occupancy rate per neighborhood by month
SELECT 
    l.neighbourhood,
    YEAR(c.date_formatted),
    MONTH(c.date_formatted),
    SUM(CASE WHEN c.available = 't' THEN 1 ELSE 0 END) AS available_days,
    SUM(CASE WHEN c.available = 'f' THEN 1 ELSE 0 END) AS booked_days,
    (SUM(CASE WHEN c.available = 'f' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS occupancy_rate
FROM 
    calendar_cleaned c
LEFT JOIN 
    listings l ON c.listing_id = l.id
GROUP BY 
    YEAR(c.date_formatted), MONTH(c.date_formatted), l.neighbourhood
ORDER BY 
    occupancy_rate ASC;
