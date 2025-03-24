CREATE DATABASE StoreFront;
USE StoreFront;
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(200) NOT NULL,
    parent_category_id INT NULL,
    FOREIGN KEY (parent_category_id)
        REFERENCES categories (category_id)
        ON DELETE SET NULL
);
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    price DECIMAL(10 , 2 ) NOT NULL,
    stock INT NOT NULL,
    status ENUM('active', 'inactive') DEFAULT 'active',
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE product_category (
	pro_cat_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (product_id)
		REFERENCES products (product_id)
        ON DELETE CASCADE,
	FOREIGN KEY (category_id)
		REFERENCES categories (category_id)
		ON DELETE CASCADE
);
CREATE TABLE images (
	image_id INT PRIMARY KEY AUTO_INCREMENT,
    image_url VARCHAR(300) NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (product_id)
		REFERENCES products (product_id)
        ON DELETE CASCADE
);
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50) NOT NULL UNIQUE,	
    role ENUM('shopper', 'administrator') NOT NULL
);
CREATE TABLE shipping_address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    house_number VARCHAR(10) NOT NULL,
    locality VARCHAR(100) NOT NULL,
    city VARCHAR(20) NOT NULL,
    state VARCHAR(20) NOT NULL,
    country VARCHAR(20) NOT NULL,
    postal_code INT NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES users (user_id)
        ON DELETE CASCADE
);
CREATE TABLE orders (
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    shipping_address_id INT NOT NULL,
    number_of_items INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)
		REFERENCES users (user_id)
        ON DELETE CASCADE,
	FOREIGN KEY (shipping_address_id)
		REFERENCES shipping_address (address_id)
        ON DELETE CASCADE
);
CREATE TABLE order_items (
	item_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    order_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    status ENUM('shipped', 'cancelled', 'returned', 'pending') DEFAULT 'pending' NOT NULL,
    FOREIGN KEY (product_id)
		REFERENCES products (product_id)
		ON DELETE CASCADE,
	FOREIGN KEY (order_id)
		REFERENCES orders (order_id)
        ON DELETE CASCADE
);

SHOW TABLES;

-- DROP TABLE Products;

-- DROP DATABASE StoreFront;