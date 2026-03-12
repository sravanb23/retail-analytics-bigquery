CREATE OR REPLACE TABLE `iconic-valve-310914.retail_dw.fact_sales` AS
SELECT
    oi.id AS order_item_id,
    oi.order_id,
    o.user_id AS customer_id,
    oi.product_id,
    p.distribution_center_id,
    DATE(o.created_at) AS order_date,
    oi.sale_price,
    1 AS quantity,
    oi.sale_price * 1 AS revenue,
    o.status,
    o.created_at
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.orders` o
    ON oi.order_id = o.order_id
JOIN `bigquery-public-data.thelook_ecommerce.products` p
    ON oi.product_id = p.id;
