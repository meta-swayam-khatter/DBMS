-- Assignment 2:

-- Display the list of products (Id, Title, Count of Categories) which fall in more than one Category.
SELECT p.product_id, p.product_name, COUNT(pc.category_id) AS category_count
	FROM products p
	JOIN product_category pc 
    ON p.product_id = pc.product_id
	GROUP BY p.product_id , p.product_name
	HAVING COUNT(pc.category_id) > 1
;

-- Count of products in different price ranges
SELECT 
    CASE
        WHEN price BETWEEN 0 AND 100 THEN '0 - 100'
        WHEN price BETWEEN 101 AND 500 THEN '101 - 500'
        ELSE 'Above 500'
    END AS price_range,
    COUNT(*) AS product_count
	FROM products
	GROUP BY price_range
;

-- Categories with number of products under each category
SELECT c.category_name, COUNT(pc.product_id) AS product_count
	FROM categories c
	LEFT JOIN product_category pc 
    ON c.category_id = pc.category_id
	GROUP BY c.category_name
;
