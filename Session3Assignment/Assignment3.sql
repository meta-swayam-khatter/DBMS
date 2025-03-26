-- Assignment 3:

-- Display Shopper’s information along with number of orders he/she placed during last 30 days.
SELECT u.user_id, u.email, COUNT(o.order_id) AS order_count
	FROM users u
	JOIN orders o
    ON u.user_id = o.user_id
	WHERE o.timestamp >= NOW() - INTERVAL 30 DAY
	GROUP BY u.user_id , u.email
;

-- Top 10 shoppers generating maximum revenue in last 30 days
SELECT u.user_id, u.email, SUM(o.price) AS total_revenue
	FROM users u
	JOIN orders o ON u.user_id = o.user_id
	WHERE o.timestamp >= NOW() - INTERVAL 30 DAY
	GROUP BY u.user_id , u.email
	ORDER BY total_revenue DESC
	LIMIT 10
;

-- Top 20 most ordered products in last 60 days
SELECT oi.product_id, p.product_name, COUNT(oi.product_id) AS order_count
	FROM order_items oi
	JOIN products p ON oi.product_id = p.product_id
	JOIN orders o ON oi.order_id = o.order_id
	WHERE o.timestamp >= NOW() - INTERVAL 60 DAY
	GROUP BY oi.product_id , p.product_name
	ORDER BY order_count DESC
	LIMIT 20
;

-- Monthly sales revenue for last 6 months
SELECT DATE_FORMAT(o.timestamp, '%Y-%m') AS month, SUM(o.price) AS total_sales
	FROM orders o
	WHERE o.timestamp >= NOW() - INTERVAL 6 MONTH
	GROUP BY month
	ORDER BY month DESC
;

-- Mark products as inactive if not ordered in last 90 days
UPDATE products 
	SET status = 'inactive'
	WHERE product_id NOT IN (
		SELECT DISTINCT product_id
        FROM order_items oi
		JOIN orders o ON oi.order_id = o.order_id
        WHERE o.timestamp >= NOW() - INTERVAL 90 DAY
	)
;

-- Display all products for a given category search keyword
SELECT p.product_id, p.product_name, c.category_name
	FROM products p
	JOIN product_category pc ON p.product_id = pc.product_id
	JOIN categories c ON pc.category_id = c.category_id
	WHERE c.category_name LIKE 'chair'
;

-- Top 10 most cancelled items
SELECT oi.product_id, p.product_name, COUNT(*) AS cancellation_count
	FROM order_items oi
	JOIN products p ON oi.product_id = p.product_id
	WHERE oi.status = 'cancelled'
	GROUP BY oi.product_id , p.product_name
	ORDER BY cancellation_count DESC
	LIMIT 10
;
