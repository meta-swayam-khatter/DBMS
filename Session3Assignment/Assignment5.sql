-- Assignment 5:

-- View displaying the order information (Id, Title, Price, Shopper’s name, Email, Orderdate, Status) with latest ordered items
-- should be displayed first for last 60 days.
CREATE VIEW order_details AS
    SELECT o.order_id, p.product_name, oi.price, u.email, o.timestamp,oi.status
    FROM orders o
	JOIN order_items oi ON o.order_id = oi.order_id
	JOIN products p ON oi.product_id = p.product_id
	JOIN users u ON o.user_id = u.user_id
    WHERE o.timestamp >= NOW() - INTERVAL 60 DAY
    ORDER BY o.timestamp DESC
;

-- Display products in 'shipped' state using the view
SELECT * FROM order_details
	WHERE status = 'shipped'
;

-- Display top 5 most selling products using the view
SELECT product_name, COUNT(order_id) AS order_count
	FROM order_details
	GROUP BY product_name
	ORDER BY order_count DESC
	LIMIT 5
;