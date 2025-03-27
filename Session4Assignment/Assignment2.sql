-- Assignment 2:

-- Create a Stored procedure to retrieve average sales of each product in a month. Month and year will be input parameter to 
-- function.
DROP PROCEDURE AverageSalesOfProduct;

select * from order_items;

DELIMITER $$
CREATE PROCEDURE AverageSalesOfProduct (orderMonth INT, orderYear INT)
BEGIN
	SELECT oi.product_id, SUM(oi.price*oi.quantity) AS total_sales_in_price, SUM(oi.quantity) AS total_sales_in_quantity, SUM(oi.price*oi.quantity)/SUM(oi.quantity) AS average_sales
	FROM order_items oi
	JOIN orders o ON oi.order_id = o.order_id
	WHERE  MONTH(o.timestamp) = orderMonth AND YEAR(o.timestamp) = orderYear
	GROUP BY oi.product_id;
END$$
DELIMITER ;

CALL AverageSalesOfProduct(03, 2025);

-- Create a stored procedure to retrieve table having order detail with status for a given period. Start date and end date 
-- will be input parameter. Put validation on input dates like start date is less than end date. If start date is greater than 
-- end date take first date of month as start date.
DROP PROCEDURE OrderDetailsWithStatus;

DELIMITER $$
CREATE PROCEDURE OrderDetailsWithStatus (startDate DATE, endDate DATE)
BEGIN
IF (startDate>endDate)
THEN
	SET startDate = endDate - INTERVAL (endDate -1) DAY;
END IF;
	SELECT o.order_id, p.product_name, oi.status
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE o.timestamp BETWEEN startDate AND endDate;
END$$
DELIMITER ;

CALL OrderDetailsWithStatus("2025-03-01", "2025-04-01");