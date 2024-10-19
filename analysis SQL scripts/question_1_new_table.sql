-- Create a table with calculated metrics for all neighborhoods
-- This will allow Tableau to visualize relevant metrics for question 1
CREATE TABLE neighborhood_metrics AS
SELECT 
    l2.neighbourhood_cleansed, 
    AVG(l.price) AS avg_rental_rate,
    SUM(l.price * (365 - l2.availability_365)) AS total_earnings,
    AVG((365 - l2.availability_365) / 365 * 100) AS avg_occupancy_rate,
    COUNT(l.id) AS listings_count,
    AVG(l2.review_scores_rating) AS avg_review_score
FROM 
    listings_2 l2
JOIN 
    listings l ON l2.id = l.id
GROUP BY 
    l2.neighbourhood_cleansed;
-- Columns:
-- neighborhood / average rental rate / total earnings per neighborhood / average occupancy rate / number of listings / average review score




