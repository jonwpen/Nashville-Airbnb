-- CTE to calculate total earnings per neighborhood
WITH neighborhood_earnings AS (
    SELECT
        l2.neighbourhood_cleansed,
        SUM(l.price * (365 - l2.availability_365)) AS total_earnings
    FROM
        listings_2 l2
    JOIN
        listings l ON l2.id = l.id
    GROUP BY
        l2.neighbourhood_cleansed
), top_neighborhoods AS ( -- CTE to select the top 5 neighborhoods from the first CTE
    SELECT
        neighbourhood_cleansed
    FROM
        neighborhood_earnings
    ORDER BY
        total_earnings DESC
    LIMIT 5
)
-- Final Query
SELECT 
    l2.neighbourhood_cleansed, 
    AVG(l.price) AS Avg_Rental_Rate,
    COUNT(l.id) AS Listings_Count
FROM 
    listings_2 l2
JOIN 
    listings l ON l2.id = l.id
JOIN
    top_neighborhoods tn ON l2.neighbourhood_cleansed = tn.neighbourhood_cleansed
WHERE 
    l2.review_scores_rating > 4.9 -- filter for listings with high review scores
    AND ((365 - l2.availability_365) / 365 * 100) > 80  -- filter for listings with high occupancy rate (above 80%)
GROUP BY 
    l2.neighbourhood_cleansed
HAVING 
    AVG((365 - l2.availability_365) / 365 * 100) > 80  -- Average occupancy rate > 80%
    AND COUNT(l.id) > 25  -- Minimum number of listings
ORDER BY 
    Avg_Rental_Rate DESC;
-- Result: Top 5 neighborhoods | average rental rate for listings with highest occupancy and highest reviews | number of listings

-- Analysis Questions to Answer:
-- What is the going rate for the top rental spots if I were to start my own Airbnb?
-- Analyze the average rental rates of properties with the highest occupancy rates(above 80%) and best reviews(above 4.9) within top-earning neighborhoods.