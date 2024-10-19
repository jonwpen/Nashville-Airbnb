-- Calculate the average monthly earnings for every neighborhood
    SELECT -- second, get the average for each neighborhood
        AVG(tot_earnings) AS average_total_earnings, 
        neighborhood
    FROM (
        SELECT -- first, get the total earnings
            SUM(l.price) AS tot_earnings, 
            l.neighbourhood AS neighborhood,
            YEAR(c.date_formatted) AS year, -- Include the year and month in the result for more granular visualization
            MONTH(c.date_formatted) AS month 
        FROM calendar_cleaned c
        LEFT JOIN listings l ON c.listing_id = l.id
        WHERE c.available = 'f'
        GROUP BY YEAR(c.date_formatted), MONTH(c.date_formatted), l.neighbourhood -- group by year so the months are continuous and unique
    ) monthly_earnings
    GROUP BY neighborhood

