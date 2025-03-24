-- Display Recent 50 Orders placed (Id, Order Date, Order Total).
SELECT order_id AS Id, timestamp AS 'Order Date', price AS 'Order Total'
	FROM orders
	ORDER BY timestamp
    LIMIT 50
;

-- Display 10 most expensive Orders.
SELECT order_id AS Id, price AS 'Order Total', timestamp
	FROM orders
    ORDER BY price DESC
    LIMIT 10
;

-- Display all the Orders which are placed more than 10 days old and one or more items from those orders are still not shipped.
SELECT DISTINCT O.order_id AS Id, O.timestamp AS 'Order Date', O.price AS 'Total Price'
	FROM orders O
    JOIN order_items OI
    WHERE OI.status = 'pending' AND O.timestamp < (current_date - INTERVAL 10 DAY)
;

-- Display list of shoppers which haven't ordered anything since last month.
SELECT user_id AS Id, email AS Email
	FROM users
    WHERE user_id NOT IN (
		SELECT DISTINCT user_id FROM orders WHERE timestamp >= (current_date - INTERVAL 1 MONTH)
	)
;

-- Display list of shopper along with orders placed by them in last 15 days
SELECT U.user_id, U.email, O.order_id, O.price
	FROM users U
    RIGHT JOIN orders O
    ON U.user_id = O.user_id
    WHERE O.timestamp >= (current_time - INTERVAL 15 DAY)
;

-- Display list of order items which are in “shipped” state for particular Order Id (i.e.: 1))
SELECT OI.item_id, OI.product_id, OI.order_id, OI.price, OI.quantity
	FROM order_items OI
    LEFT JOIN orders O
    ON  OI.order_id = O.order_id
    WHERE OI.order_id = 1
;

-- Display list of order items along with order placed date which fall between Rs 20000 to Rs 50000 price.
SELECT OI.item_id, OI.product_id, OI.order_id, OI.price, OI.quantity, O.timestamp
	FROM order_items OI
	LEFT JOIN orders O
    ON OI.order_id = O.order_id
    WHERE OI.price BETWEEN 20000 AND 50000
;