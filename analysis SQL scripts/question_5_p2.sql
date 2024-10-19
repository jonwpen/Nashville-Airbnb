WITH percentile_table AS (
	SELECT 
		SUM(l.price) AS earnings, 
		l.id,
		PERCENT_RANK() OVER (ORDER BY SUM(l.price)) AS percentile_rank
	FROM 
		calendar_cleaned c
	JOIN 
		listings l
	ON 
		c.listing_id = l.id
	GROUP BY 
		l.id
	ORDER BY earnings DESC) 
    SELECT 
    (SUM(earnings) / (SELECT SUM(earnings) FROM percentile_table)) * 100 AS top_10_earnings_percentage
FROM 
    top_10_percent;



-- Compare the total earnings of the top 10% to the total earnings of the bottom 90%.

-- temporary table top_10_percent