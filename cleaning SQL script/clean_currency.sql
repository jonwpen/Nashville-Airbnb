DELIMITER $$

CREATE PROCEDURE UpdatePrices()
BEGIN
    -- Variables to track rows affected
    DECLARE done INT DEFAULT FALSE;
    DECLARE rows_affected INT;
    SET rows_affected = 1;  -- Initialize to enter the loop

    -- Loop until no rows are affected by the update
    WHILE rows_affected > 0 DO
        -- Update command in batches
        UPDATE calendar
        SET price = REPLACE(price, '$', '')
        WHERE price LIKE '$%'
        LIMIT 10000;  -- Process 10,000 rows at a time

        -- Get the number of affected rows
        SET rows_affected = ROW_COUNT();
    END WHILE;
END$$

DELIMITER ;
