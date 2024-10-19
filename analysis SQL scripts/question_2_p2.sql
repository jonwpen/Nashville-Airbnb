SELECT 
    SUM(CASE WHEN c.available = 'f' THEN 1 ELSE 0 END) AS booked_count,
    
    SUM(CASE WHEN c.available = 't' THEN 1 ELSE 0 END) AS available_count,
    
    YEAR(c.date_formatted) AS year,  -- Group by year
    
    MONTH(c.date_formatted) AS month,  -- Group by month
    
    l.room_type,
    
    (SUM(CASE WHEN available = 'f' THEN 1 ELSE 0 END) * 100.0) / 
	(SUM(CASE WHEN available = 'f' THEN 1 ELSE 0 END) + SUM(CASE WHEN available = 't' THEN 1 ELSE 0 END)) AS occupancy_rate
FROM 
    calendar_cleaned c
JOIN listings l
ON c.listing_id = l.id
GROUP BY 
	l.room_type,
    YEAR(c.date_formatted), 
    MONTH(c.date_formatted)  
ORDER BY 
    year,
    month,
    l.room_type;

-- ^Find availability and occupancy rates by room type.