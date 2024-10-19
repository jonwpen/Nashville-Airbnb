-- Add a new column to hold the date values
#ALTER TABLE listings
#ADD COLUMN last_review_date DATE;

-- Update the new column with converted dates from the original last_review column
UPDATE listings
SET last_review_date = STR_TO_DATE(last_review, '%Y-%m-%d')
WHERE last_review IS NOT NULL;

