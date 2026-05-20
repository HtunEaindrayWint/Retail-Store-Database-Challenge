-- Difficulty in Accessing Data (Retail Store)
-- table creation script
-- sample data population
-- workflow problem simulation
-- DBMS solution queries
-- test case scripts

CREATE DATABASE bad_retaildb;
USE bad_retaildb;

-- File-Based Style Tables
-- These tables simulate separate files:
-- sales file
-- stores file
-- products file
-- In a file-based system, reporting usually needs manual extraction and custom joining.
-- =========================================
-- FILE-BASED STYLE TABLES
-- =========================================

DROP TABLE IF EXISTS sales_file;
DROP TABLE IF EXISTS stores_file;
DROP TABLE IF EXISTS products_file;

CREATE TABLE stores_file (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE products_file (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE sales_file (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_date DATE NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL
);

-- =========================================
-- POPULATE MASTER FILES
-- =========================================

INSERT INTO stores_file (store_id, store_name, region, city) VALUES
(1, 'Yangon Central Store', 'South', 'Yangon'),
(2, 'Mandalay Plaza Store', 'Central', 'Mandalay'),
(3, 'Naypyitaw Junction Store', 'Central', 'Naypyitaw'),
(4, 'Mawlamyine Market Store', 'South', 'Mawlamyine'),
(5, 'Taunggyi Hill Store', 'East', 'Taunggyi'),
(6, 'Myitkyina Star Store', 'North', 'Myitkyina');

INSERT INTO products_file (product_id, product_name, category, unit_price) VALUES
(101, 'Rice Bag', 'Grocery', 45000.00),
(102, 'Cooking Oil', 'Grocery', 12000.00),
(103, 'Instant Noodles', 'Grocery', 800.00),
(104, 'Soft Drink', 'Beverage', 1500.00),
(105, 'Shampoo', 'Personal Care', 7000.00),
(106, 'Soap', 'Personal Care', 2500.00);

-- =========================================
-- POPULATE SALES DATA
-- 6 months sample transactions
-- =========================================

INSERT INTO sales_file (sale_date, store_id, product_id, quantity, total_amount) VALUES
('2025-10-05', 1, 101, 10, 450000.00),
('2025-10-12', 2, 102, 20, 240000.00),
('2025-10-18', 3, 103, 100, 80000.00),
('2025-10-22', 4, 104, 60, 90000.00),
('2025-10-25', 5, 105, 15, 105000.00),
('2025-10-28', 6, 106, 30, 75000.00),

('2025-11-03', 1, 102, 25, 300000.00),
('2025-11-07', 2, 101, 8, 360000.00),
('2025-11-11', 3, 104, 70, 105000.00),
('2025-11-15', 4, 103, 120, 96000.00),
('2025-11-19', 5, 106, 40, 100000.00),
('2025-11-24', 6, 105, 12, 84000.00),

('2025-12-02', 1, 103, 150, 120000.00),
('2025-12-06', 2, 104, 80, 120000.00),
('2025-12-10', 3, 101, 9, 405000.00),
('2025-12-14', 4, 102, 18, 216000.00),
('2025-12-18', 5, 105, 20, 140000.00),
('2025-12-22', 6, 106, 35, 87500.00),

('2026-01-05', 1, 104, 90, 135000.00),
('2026-01-08', 2, 103, 140, 112000.00),
('2026-01-12', 3, 102, 22, 264000.00),
('2026-01-16', 4, 101, 7, 315000.00),
('2026-01-20', 5, 106, 55, 137500.00),
('2026-01-27', 6, 105, 10, 70000.00),

('2026-02-03', 1, 105, 18, 126000.00),
('2026-02-07', 2, 106, 50, 125000.00),
('2026-02-11', 3, 104, 75, 112500.00),
('2026-02-15', 4, 103, 160, 128000.00),
('2026-02-19', 5, 101, 11, 495000.00),
('2026-02-24', 6, 102, 16, 192000.00),

('2026-03-04', 1, 106, 60, 150000.00),
('2026-03-08', 2, 105, 14, 98000.00),
('2026-03-12', 3, 103, 180, 144000.00),
('2026-03-16', 4, 104, 95, 142500.00),
('2026-03-20', 5, 102, 21, 252000.00),
('2026-03-25', 6, 101, 13, 585000.00);
