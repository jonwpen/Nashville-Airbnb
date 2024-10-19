DELIMITER $$

CREATE PROCEDURE ConvertPriceToDecimal()
BEGIN
    -- Variable to hold the command
    DECLARE done INT DEFAULT FALSE;
    DECLARE continue HANDLER FOR SQLSTATE '02000' SET done = 1;

    -- Alter column to new data type without losing data
    ALTER TABLE calendar MODIFY price DECIMAL(10,2);

    -- Batch process to safely convert values
    REPEAT
        -- Assuming `id` is a primary key that can help in batch processing
        UPDATE calendar 
        SET price = CAST(price AS DECIMAL(10,2))
        WHERE id <= (SELECT MAX(id) FROM calendar)
        LIMIT 10000;  -- Adjust the batch size based on your server's capability

        -- Check for completion
        IF ROW_COUNT() = 0 THEN
            SET done = 1;
        END IF;
    UNTIL done END REPEAT;
END$$

DELIMITER ;
