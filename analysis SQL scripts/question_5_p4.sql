SELECT 
    l.room_type,
    COUNT(t.id) AS num_properties,
    SUM(t.earnings) AS total_earnings
FROM 
    top_10_percent t
JOIN 
    listings l ON t.id = l.id
GROUP BY 
    l.room_type
ORDER BY 
    total_earnings DESC;

-- Top ten percecnt of earners, segmented by room type