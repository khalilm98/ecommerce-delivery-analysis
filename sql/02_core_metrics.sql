-- Total orders, revenue, and freight
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(price) AS total_revenue,
    SUM(freight_value) AS total_freight
FROM olist_base;

-- Monthly orders and revenue trend
SELECT
    DATE_TRUNC('month', order_purchase_timestamp) AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(price) AS total_revenue
FROM olist_base
GROUP BY month
ORDER BY month;

-- Top 10 categories by revenue
SELECT
    product_category_name_english AS category,
    SUM(price) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM olist_base
GROUP BY product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;