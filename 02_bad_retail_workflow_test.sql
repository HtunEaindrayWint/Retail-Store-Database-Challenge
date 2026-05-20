-- Workflow Problem Script
-- This section demonstrates the file-based reporting problem.
-- Manager asks:
-- “Sales report for last 6 months by region”
-- In a file-based environment:
-- sales are in one file
-- stores are in another file
-- region is not directly available in sales file
-- manual extraction or custom programming is required
-- Step 1: View separate files
SELECT * FROM sales_file;
SELECT * FROM stores_file;
SELECT * FROM products_file;

-- Without a proper integrated design, report logic becomes custom and repetitive
SELECT 
    s.sale_date,
    s.store_id,
    st.store_name,
    st.region,
    s.total_amount
FROM sales_file s
JOIN stores_file st ON s.store_id = st.store_id
WHERE s.sale_date BETWEEN '2025-10-01' AND '2026-03-31'
ORDER BY st.region, s.sale_date;
