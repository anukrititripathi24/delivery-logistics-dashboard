CREATE DATABASE delivery_db;
USE delivery_db;
-- Create locations table
CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100)
);

-- Create partners table
CREATE TABLE partners (
    partner_id INT PRIMARY KEY,
    partner_name VARCHAR(100)
);

-- Create shipping table
CREATE TABLE shipping (
    shipping_id INT PRIMARY KEY,
    partner_id INT,
    distance_km FLOAT,
    shipped_date DATE,
    delivered_date DATE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    delivery_date DATE,
    shipping_id INT,
    status VARCHAR(20)
);

INSERT INTO locations VALUES
(1, 'Mumbai', 'Maharashtra'),
(2, 'Delhi', 'Delhi'),
(3, 'Bangalore', 'Karnataka'),
(4, 'Hyderabad', 'Telangana'),
(5, 'Chennai', 'Tamil Nadu');

INSERT INTO partners VALUES
(1, 'BlueDart'),
(2, 'Delhivery'),
(3, 'EcomExpress'),
(4, 'XpressBees');

INSERT INTO shipping VALUES
(1, 1, 123.45, '2025-06-03', '2025-06-06'),
(2, 2, 98.76, '2025-06-02', '2025-06-04'),
(3, 3, 240.12, '2025-06-01', '2025-06-05'),
(4, 1, 45.67, '2025-06-05', '2025-06-07'),
(5, 4, 180.50, '2025-06-03', '2025-06-06');

INSERT INTO orders VALUES
(1, 1, '2025-06-02', '2025-06-06', 1, 'Delivered'),
(2, 2, '2025-06-01', '2025-06-04', 2, 'Delivered'),
(3, 3, '2025-06-01', NULL, 3, 'Failed'),
(4, 4, '2025-06-05', '2025-06-07', 4, 'Delivered'),
(5, 5, '2025-06-02', '2025-06-06', 5, 'Delivered');

SELECT * FROM locations;
SELECT * FROM partners;
SELECT * FROM shipping;
INSERT INTO shipping VALUES
(9, 2, 350.25, '2025-06-04', '2025-06-07'),
(10, 3, 120.75, '2025-06-06', '2025-06-09'),
(11, 4, 88.60, '2025-06-02', '2025-06-06'),
(12, 1, 305.10, '2025-06-07', '2025-06-10'),
(13, 2, 99.99, '2025-06-05', '2025-06-08'),
(14, 3, 275.45, '2025-06-03', '2025-06-07'),
(15, 4, 450.00, '2025-06-08', '2025-06-12'),
(16, 1, 65.20, '2025-06-09', '2025-06-11'),
(17, 2, 150.00, '2025-06-06', '2025-06-08'),
(18, 3, 340.70, '2025-06-04', '2025-06-07');

INSERT INTO orders VALUES
(9, 2, '2025-06-03', '2025-06-07', 9, 'Delivered'),
(10, 4, '2025-06-05', '2025-06-09', 10, 'Delivered'),
(11, 1, '2025-06-01', NULL, 11, 'Failed'),
(12, 3, '2025-06-06', '2025-06-10', 12, 'Delivered'),
(13, 5, '2025-06-04', '2025-06-08', 13, 'Delivered'),
(14, 2, '2025-06-02', NULL, 14, 'Failed'),
(15, 4, '2025-06-07', '2025-06-12', 15, 'Delivered'),
(16, 5, '2025-06-08', '2025-06-11', 16, 'Delivered'),
(17, 1, '2025-06-06', '2025-06-08', 17, 'Delivered'),
(18, 3, '2025-06-03', '2025-06-07', 18, 'Delivered');

SELECT * FROM locations;
SELECT * FROM partners;
SELECT * FROM shipping;
SELECT * FROM orders;

SELECT 
    l.city,
    ROUND(AVG(DATEDIFF(o.delivery_date, o.order_date)), 2) AS avg_delivery_days
FROM orders o
JOIN locations l ON o.customer_id = l.location_id
WHERE o.status = 'Delivered'
GROUP BY l.city;

SELECT 
    l.city,
    COUNT(CASE WHEN o.status = 'Failed' THEN 1 END) * 100.0 / COUNT(*) AS failed_delivery_pct
FROM orders o
JOIN locations l ON o.customer_id = l.location_id
GROUP BY l.city;

SELECT 
    p.partner_name,
    ROUND(AVG(DATEDIFF(s.delivered_date, s.shipped_date)), 2) AS avg_shipping_days
FROM shipping s
JOIN partners p ON s.partner_id = p.partner_id
JOIN orders o ON o.shipping_id = s.shipping_id
WHERE o.status = 'Delivered'
GROUP BY p.partner_name
ORDER BY avg_shipping_days ASC;

SELECT 
    s.distance_km,
    DATEDIFF(o.delivery_date, o.order_date) AS delivery_days
FROM shipping s
JOIN orders o ON o.shipping_id = s.shipping_id
WHERE o.status = 'Delivered';












