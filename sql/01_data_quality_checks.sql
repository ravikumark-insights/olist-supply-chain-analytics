USE OlistSupplyChain;
GO

-- Row counts per table
SELECT 'fact_orders'    AS table_name, COUNT(*) AS row_count FROM fact_orders
UNION ALL
SELECT 'dim_sellers',    COUNT(*) FROM dim_sellers
UNION ALL
SELECT 'dim_products',   COUNT(*) FROM dim_products
UNION ALL
SELECT 'dim_customers',  COUNT(*) FROM dim_customers;
GO

--  Check for nulls in key columns
SELECT 
    SUM(CASE WHEN order_id         IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN customer_id      IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN on_time_flag     IS NULL THEN 1 ELSE 0 END) AS null_on_time,
    SUM(CASE WHEN delay_days       IS NULL THEN 1 ELSE 0 END) AS null_delay,
    SUM(CASE WHEN total_revenue    IS NULL THEN 1 ELSE 0 END) AS null_revenue,
    SUM(CASE WHEN review_score     IS NULL THEN 1 ELSE 0 END) AS null_review
FROM fact_orders;
GO

-- Date range check
SELECT 
    MIN(order_purchase_timestamp) AS earliest_order,
    MAX(order_purchase_timestamp) AS latest_order,
    COUNT(DISTINCT order_year)    AS years_of_data
FROM fact_orders;
GO

--  Order status distribution
SELECT 
    delay_severity,
    COUNT(*)                                        AS order_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct_of_total
FROM fact_orders
GROUP BY delay_severity
ORDER BY order_count DESC;
GO