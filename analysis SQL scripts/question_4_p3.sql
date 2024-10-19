-- Calculate occupancy rate per neighborhood by month
SELECT 
    l.neighbourhood,
    DATE_FORMAT(c.date_formatted, '%Y-%m-01') AS month_start_date,  -- This keeps the date format as 'YYYY-MM-01', but still groups by month
    SUM(CASE WHEN c.available = 't' THEN 1 ELSE 0 END) AS available_days,
    SUM(CASE WHEN c.available = 'f' THEN 1 ELSE 0 END) AS booked_days,
    (SUM(CASE WHEN c.available = 'f' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS occupancy_rate
FROM 
    calendar_cleaned c
LEFT JOIN 
    listings l ON c.listing_id = l.id
GROUP BY 
    month_start_date, l.neighbourhood
ORDER BY 
    occupancy_rate;
