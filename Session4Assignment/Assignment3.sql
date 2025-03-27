-- Assignment 3:

-- Index for Orders Table (Indexing OrderDate for faster queries on date filtering)
CREATE INDEX idx_orders_date ON Orders (timestamp);

-- Index for Products Table (Indexing ProductID for faster joins with OrderDetails)
CREATE INDEX idx_products_id ON Products (product_iD);

-- Index for Categories Table (Indexing CategoryID for quicker category-based lookups)
CREATE INDEX idx_categories_id ON Categories (category_iD);
