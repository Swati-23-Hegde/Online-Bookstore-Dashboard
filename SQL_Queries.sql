-- Sales_Fact Table — main transactional data
SELECT 
    o.order_id,
    o.order_date,
    o.quantity,
    o.total_amount,
    b.book_id,
    b.title,
    b.author,
    b.genre,
    b.price,
    c.customer_id,
    c.name AS customer_name,
    c.city,
    c.country
FROM orders o
JOIN books b ON o.book_id = b.book_id
JOIN customers c ON o.customer_id = c.customer_id;

-- Inventory_Status Table (Stock vs. Sold)
SELECT 
    b.book_id, 
    b.title, 
    b.stock,
    COALESCE(SUM(o.quantity),0) AS sold_quantity,
    b.stock - COALESCE(SUM(o.quantity),0) AS remaining_stock
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock;

--Customer_Spend Table (Customer-wise summary)
SELECT 
    o.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.name;

