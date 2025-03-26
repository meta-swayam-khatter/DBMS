-- Assignment 1:

-- Categories Table:
-- - category_id: PRIMARY KEY, AUTO_INCREMENT
-- - category_name: NOT NULL
-- - parent_category_id: FOREIGN KEY referencing categories(category_id), allows NULL

-- Products Table:
-- - product_id: PRIMARY KEY, AUTO_INCREMENT
-- - product_name: NOT NULL
-- - price: NOT NULL
-- - stock: NOT NULL
-- - status: ENUM ('active', 'inactive')
-- - timestamp: DEFAULT CURRENT_TIMESTAMP

-- Product_category Table:
-- - pro_cat_id: PRIMARY KEY, AUTO_INCREMENT
-- - product_id: FOREIGN KEY referencing products(product_id)
-- - category_id: FOREIGN KEY referencing categories(category_id)

-- Images Table:
-- - image_id: PRIMARY KEY, AUTO_INCREMENT
-- - image_url: NOT NULL
-- - product_id: FOREIGN KEY referencing products(product_id)

-- Users Table:
-- - user_id: PRIMARY KEY, AUTO_INCREMENT
-- - email: NOT NULL, UNIQUE
-- - role: ENUM ('shopper', 'administrator')

-- Shipping_address Table:
-- - address_id: PRIMARY KEY, AUTO_INCREMENT
-- - user_id: FOREIGN KEY referencing users(user_id)
-- - house_number: NOT NULL
-- - locality: NOT ULL
-- - city: NOT NULL
-- - state: NOT NULL
-- - country: NOT NULL
-- - postal_code: NOT NULL

-- Orders Table:
-- - order_id: PRIMARY KEY, AUTO_INCREMENT
-- - user_id: FOREIGN KEY referencing users(user_id)
-- - shipping_address_id: FOREIGN KEY referencing shipping_address(address_id)
-- - number_of_items: NOT NULL
-- - price: NOT NULL
-- - timestamp: DEFAULT CURRENT_TIMESTAMP

-- Order_items Table:
-- - item_id: PRIMARY KEY, AUTO_INCREMENT
-- - product_id: FOREIGN KEY referencing products(product_id)
-- - order_id: FOREIGN KEY referencing orders(order_id)
-- - price: NOT NULL
-- - quantity: NOT NULL
-- - status: ENUM('shipped', 'cancelled', 'returned', 'pending')
