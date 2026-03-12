-- Create Product Dimension
CREATE OR REPLACE TABLE `iconic-valve-310914.retail_dw.dim_products` AS
SELECT
    id AS product_id,
    name AS product_name,
    brand,
    category,
    department,
    retail_price
FROM `bigquery-public-data.thelook_ecommerce.products`;

-- Create Customer Dimension
CREATE OR REPLACE TABLE `iconic-valve-310914.retail_dw.dim_customers` AS
SELECT
    id AS customer_id,
    first_name,
    last_name,
    gender,
    age,
    city,
    state,
    country,
    traffic_source,
    created_at
FROM `bigquery-public-data.thelook_ecommerce.users`;

-- Create Distribution Center Dimension
CREATE OR REPLACE TABLE `iconic-valve-310914.retail_dw.dim_distribution_centers` AS
SELECT
    id AS distribution_center_id,
    name,
    latitude,
    longitude
FROM `bigquery-public-data.thelook_ecommerce.distribution_centers`;

-- Create Date Dimension
CREATE OR REPLACE TABLE `iconic-valve-310914.retail_dw.dim_date` AS
SELECT
    date AS date_id,
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    EXTRACT(DAY FROM date) AS day,
    EXTRACT(QUARTER FROM date) AS quarter,
    FORMAT_DATE('%A', date) AS day_of_week
FROM UNNEST(GENERATE_DATE_ARRAY('2019-01-01', '2030-12-31')) AS date;
