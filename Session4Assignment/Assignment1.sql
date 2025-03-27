-- Assignment 1:

-- Create a function to calculate number of orders in a month. Month and year will be input parameter to function.
DELIMITER $$
CREATE FUNCTION GetOrdersCount(orderMonth INT, orderYear INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE OrderCount INT;
    SET OrderCount = (
		SELECT COUNT(o.order_id)
		FROM Orders o
		WHERE MONTH(o.timestamp) = orderMonth AND YEAR(o.timestamp) = orderYear
    );
    RETURN OrderCount;
END$$
DELIMITER ;

SELECT GetOrdersCount(03, 2025);


-- Create a function to return month in a year having maximum orders. Year will be input parameter.
DELIMITER $$
CREATE FUNCTION MonthWithMaximumOrders(orderYear INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE MaxOrderMonth INT;
    SET MaxOrderMonth = (
		SELECT MONTH(timestamp)
        FROM Orders
        WHERE YEAR(timestamp) = orderYear
        GROUP BY MONTH(timestamp)
        ORDER BY COUNT(*) DESC
        LIMIT 1
	);
    RETURN MaxOrderMonth;
END $$
DELIMITER ;

SELECT MonthWithMaximumOrders(2025);