SELECT date, COUNT(*)
FROM reviews_2
WHERE STR_TO_DATE(date, '%Y-%m-%d') IS NULL AND date IS NOT NULL
GROUP BY date;

-- before converting dates from text to date format, this checks for rows where the date is not properly
-- written in ####-##-## format.