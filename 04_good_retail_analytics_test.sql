-- Workflow for DBMS Solution
-- the manager’s question can be answered directly by SQL.
-- Sales report for last 6 months by region
SELECT 
    st.region,
    SUM(s.total_amount) AS total_sales
FROM sales s
JOIN stores st ON s.store_id = st.store_id
WHERE s.sale_date BETWEEN '2025-10-01' AND '2026-03-31'
GROUP BY st.region
ORDER BY total_sales DESC;

-- Monthly sales report by region
SELECT 
    DATE_FORMAT(s.sale_date, '%Y-%m') AS sales_month,
    st.region,
    SUM(s.total_amount) AS total_sales
FROM sales s
JOIN stores st ON s.store_id = st.store_id
WHERE s.sale_date BETWEEN '2025-10-01' AND '2026-03-31'
GROUP BY DATE_FORMAT(s.sale_date, '%Y-%m'), st.region
ORDER BY sales_month, st.region;

-- Ad-hoc report: sales by region and product category
SELECT 
    st.region,
    p.category,
    SUM(s.total_amount) AS total_sales
FROM sales s
JOIN stores st ON s.store_id = st.store_id
JOIN products p ON s.product_id = p.product_id
WHERE s.sale_date BETWEEN '2025-10-01' AND '2026-03-31'
GROUP BY st.region, p.category
ORDER BY st.region, total_sales DESC;
-- Create Reporting View

DROP VIEW IF EXISTS vw_sales_reporting;

CREATE VIEW vw_sales_reporting AS
SELECT
    s.sale_id,
    s.sale_date,
    st.store_id,
    st.store_name,
    st.region,
    st.city,
    p.product_id,
    p.product_name,
    p.category,
    s.quantity,
    s.total_amount
FROM sales s
JOIN stores st ON s.store_id = st.store_id
JOIN products p ON s.product_id = p.product_id;

SELECT * FROM vw_sales_reporting;

-- Test Case Scripts
-- Test Case 1: File-based access is difficult
-- Raw sales file does not directly show region
USE bad_retaildb;
SELECT 
    sale_id,
    sale_date,
    store_id,
    total_amount
FROM sales_file
WHERE sale_date BETWEEN '2025-10-01' AND '2026-03-31';

-- Test Case 2: Join is required to retrieve region

SELECT 
    s.sale_id,
    s.sale_date,
    st.region,
    s.total_amount
FROM sales_file s
JOIN stores_file st ON s.store_id = st.store_id
WHERE s.sale_date BETWEEN '2025-10-01' AND '2026-03-31';

-- Test Case 3: DBMS quickly answers manager’s question
USE good_retaildb;
SELECT 
    st.region,
    SUM(s.total_amount) AS total_sales
FROM sales s
JOIN stores st ON s.store_id = st.store_id
WHERE s.sale_date BETWEEN '2025-10-01' AND '2026-03-31'
GROUP BY st.region
ORDER BY total_sales DESC;

-- Test Case 4: Ad-hoc reporting

SELECT 
    region,
    COUNT(*) AS transaction_count,
    SUM(total_amount) AS total_sales
FROM vw_sales_reporting
WHERE sale_date BETWEEN '2025-10-01' AND '2026-03-31'
GROUP BY region
ORDER BY total_sales DESC;

-- Test Case 5: Monthly trend by region
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
    region,
    SUM(total_amount) AS total_sales
FROM vw_sales_reporting
WHERE sale_date BETWEEN '2025-10-01' AND '2026-03-31'
GROUP BY DATE_FORMAT(sale_date, '%Y-%m'), region
ORDER BY sales_month, region;
