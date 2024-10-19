
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
SELECT * 
FROM percentile_table
WHERE percentile_rank >= 0.90;

-- ^get the total annual earnings per listing, the listing id, and the percentile rank for each listing.

-- ^When the WHERE clause needs to reference an alias of a column that is calculated in the SELECT statement, you can first put the query into a CTE.