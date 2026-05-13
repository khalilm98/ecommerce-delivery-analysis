-- Average review score by delivery status
SELECT
    delivery_status,
    AVG(review_score) AS avg_review_score,
    COUNT(DISTINCT order_id) AS total_orders
FROM (
    SELECT
        order_id,
        review_score,
        CASE
            WHEN order_delivered_customer_date IS NULL THEN 'Not Delivered'
            WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'Late'
            ELSE 'On Time'
        END AS delivery_status
    FROM olist_base
) t
GROUP BY delivery_status
ORDER BY avg_review_score DESC;

-- Proportion of orders by delivery status
SELECT
    delivery_status,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        COUNT(DISTINCT order_id)
        / SUM(COUNT(DISTINCT order_id)) OVER (),
        3
    ) AS proportion
FROM (
    SELECT
        order_id,
        CASE
            WHEN order_delivered_customer_date IS NULL THEN 'Not Delivered'
            WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'Late'
            ELSE 'On Time'
        END AS delivery_status
    FROM olist_base
) t
GROUP BY delivery_status
ORDER BY total_orders DESC;

-- Revenue by delivery status
SELECT
    delivery_status,
    ROUND(SUM(price), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM (
    SELECT
        order_id,
        price,
        CASE
            WHEN order_delivered_customer_date IS NULL THEN 'Not Delivered'
            WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'Late'
            ELSE 'On Time'
        END AS delivery_status
    FROM olist_base
) t
GROUP BY delivery_status
ORDER BY total_revenue DESC;