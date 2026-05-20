-- DBMS Solution Design
-- =========================================
-- DBMS SOLUTION TABLES
-- =========================================
CREATE DATABASE good_retaildb;
USE good_retaildb;

DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS stores;
DROP TABLE IF EXISTS products;

CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_date DATE NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_sales_store FOREIGN KEY (store_id) REFERENCES stores(store_id),
    CONSTRAINT fk_sales_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO good_retaildb.stores
SELECT * FROM bad_retaildb.stores_file;

INSERT INTO good_retaildb.products
SELECT * FROM bad_retaildb.products_file;

INSERT INTO good_retaildb.sales (sale_date, store_id, product_id, quantity, total_amount)
SELECT sale_date, store_id, product_id, quantity, total_amount
FROM bad_retaildb.sales_file;
