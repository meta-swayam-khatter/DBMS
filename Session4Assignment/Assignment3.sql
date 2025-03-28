-- Assignment 3:

-- Index for Orders Table (Indexing OrderDate for faster queries on date filtering)
CREATE INDEX idx_orders_date ON Orders (order_id);

-- Index for Products Table (Indexing ProductID for faster joins with OrderDetails)
CREATE INDEX idx_products_id ON Products (product_id);

-- Index for Categories Table (Indexing CategoryID for quicker category-based lookups)
CREATE INDEX idx_categories_id ON Categories (category_id);
