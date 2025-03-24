INSERT INTO categories (category_name, parent_category_id) VALUE 
	('Electronics', NULL),
    ('Furniture', NULL),
    ('Mobile', 1),
    ('Laptop', 1),
    ('Chair', 2),
    ('Table', 2)
;

INSERT INTO products (product_name, price, stock) VALUES
	('Samsung F62', 25000.00, 100),
    ('HP Pavilion Gaming', 60000.00, 20),
    ('HyperX', 15000, 30),
    ('Adjustable table', 20000, 10),
    ('Massage chair', 12000, 5)
;

INSERT INTO product_category (product_id, category_id) VALUES
	(1, 3),
	(2, 4),
    (3, 5),
    (4, 6),
    (5, 1),
    (5, 5)
;

INSERT INTO images (image_url, product_id) VALUES
	('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQclVHW4MpnhVRh5uIGVFmcODL-X1yEdmYWKw&s', 1),
    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGQN4hPKKVAq7FTlZAqx97GaK82pnqOTf0Fg&s', 2),
    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkjb4rvv1VlCdbHulnjXDFXnBZfzEA5IOKE_GF-3X1Kk1BjY5CYm1XHs3FldJyw7PQxV4&usqp=CAU', 2)
;

INSERT INTO users (email, role) VALUES
	('admin@domain.com', 'administrator'),
	('user1@gmail.com', 'shopper'),
    ('user2@gmail.com', 'shopper')
;

INSERT INTO shipping_address (user_id, house_number, locality, city, state, country, postal_code) VALUES
	(2, '121', 'malviyay nagar', 'jaipur', 'rajasthan', 'india', 302017),
	(3, '14-B', 'jagatpura', 'jaipur', 'rajasthan', 'india', 123456)
;

INSERT INTO orders (user_id, shipping_address_id, number_of_items, price) VALUES
	(1, 1, 2, 85000),
    (1, 1, 1, 12000),
    (2, 2, 3, 95000)
;

INSERT INTO order_items (product_id, order_id, price, quantity) VALUES
	(1, 1, 25000, 1),
    (2, 1, 60000, 1),
    (5, 2, 12000, 1),
    (2, 3, 60000, 1),
    (3, 3, 15000, 1),
    (4, 3, 20000, 1)
;

-- Display Id, Title, Category Title, Price of the products which are Active and recently added products should be at top.
CREATE VIEW product_with_category AS
	SELECT P.product_id AS product_id, P.product_name AS product_name, P.price AS price, P.timestamp AS timestamp, P.status AS status, C.category_id AS category_id
		FROM products P
		LEFT JOIN product_category C
        ON P.product_id = C.product_id
	;

SELECT P.product_id AS Id, P.product_name AS Title, C.category_name AS Category_Title, P.price AS Price, P.timestamp AS created_at
	FROM product_with_category P
    LEFT JOIN categories C
    ON P.category_id = C.category_id
    WHERE P.status = 'active'
    ORDER BY P.timestamp DESC
;

-- Display the list of products which don't have any images.
SELECT P.product_id AS product_id, P.product_name AS product_name, P.price AS price, P.stock AS stock, I.image_url AS image_url
	FROM products P 
    LEFT JOIN images I 
    ON P.product_id = I.product_id
	WHERE I.image_url IS NULL
;

-- Display all Id, Title and Parent Category Title for all the Categories listed, sorted by Parent Category Title and then Category Title. (If Category is top category then Parent Category Title column should display “Top Category” as value.)
SELECT C.category_id AS category_id, C.category_name AS Title, COALESCE(P.category_name, 'Top Category') AS parent_category_name
	FROM categories C
    LEFT JOIN categories P
    ON C.parent_category_id = P.category_id
    ORDER BY P.category_name, C.category_name
;

-- Display Id, Title, Parent Category Title of all the leaf Categories (categories which are not parent of any other category)
SELECT P.category_id AS category_id, P.category_name AS Title, C.category_name AS parent_category_name
	FROM categories C
    INNER JOIN categories P
    ON C.category_id = P.parent_category_id
;

-- Display Product Title, Price & Description which falls into particular category Title (i.e. “Mobile”)
SELECT P.product_name AS Title, P.price AS price
	FROM product_with_category P
    LEFT JOIN categories C
    ON P.category_id = C.category_id
    WHERE C.category_name = 'Mobile'
;

-- Display the list of Products whose Quantity on hand (Inventory) is under 50.
SELECT product_id, product_name, price, stock
	FROM products
	WHERE stock<50
;