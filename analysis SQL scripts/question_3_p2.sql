-- Calculate the average total earnings per neighborhood, and then find the highest and lowest earnings
WITH neighborhood_earnings AS (
    -- Calculate average total earnings per neighborhood
    SELECT 
        AVG(tot_earnings) AS average_total_earnings, 
        neighborhood
    FROM (
        -- Calculate total earnings for each neighborhood by year
        SELECT 
            SUM(l.price) AS tot_earnings, 
            l.neighbourhood AS neighborhood
        FROM calendar_cleaned c
        LEFT JOIN listings l ON c.listing_id = l.id
        WHERE c.available = 'f'
        GROUP BY YEAR(c.date_formatted), l.neighbourhood
    ) monthly_earnings
    GROUP BY neighborhood
)
-- Find the highest and lowest earnings
SELECT *
FROM neighborhood_earnings
WHERE average_total_earnings = (SELECT MAX(average_total_earnings) FROM neighborhood_earnings)
   OR average_total_earnings = (SELECT MIN(average_total_earnings) FROM neighborhood_earnings);