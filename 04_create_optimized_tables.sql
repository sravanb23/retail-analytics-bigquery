-- Optimized Product Dimension
CREATE OR REPLACE TABLE `iconic-valve-310914.retail_dw.dim_products_opt`
CLUSTER BY department, category, brand AS
SELECT
  product_id,
  product_name,
  brand,
  category,
  department,
  retail_price
FROM `iconic-valve-310914.retail_dw.dim_products`;

-- Optimized Customer Dimension
CREATE OR REPLACE TABLE `iconic-valve-310914.retail_dw.dim_customers_opt`
CLUSTER BY country, state, traffic_source AS
SELECT
  customer_id,
  first_name,
  last_name,
  gender,
  age,
  city,
  state,
  country,
  traffic_source,
  created_at
FROM `iconic-valve-310914.retail_dw.dim_customers`;

-- Optimized Distribution Center Dimension
CREATE OR REPLACE TABLE `iconic-valve-310914.retail_dw.dim_distribution_centers_opt` AS
SELECT
  distribution_center_id,
  name,
  latitude,
  longitude
FROM `iconic-valve-310914.retail_dw.dim_distribution_centers`;

-- Optimized Date Dimension (clustered only; not partitioned)
CREATE OR REPLACE TABLE `iconic-valve-310914.retail_dw.dim_date_opt`
CLUSTER BY year, quarter, month AS
SELECT
  date_id,
  year,
  month,
  day,
  quarter,
  day_of_week
FROM `iconic-valve-310914.retail_dw.dim_date`;

-- Optimized Fact Table
CREATE OR REPLACE TABLE `iconic-valve-310914.retail_dw.fact_sales_opt`
PARTITION BY order_date
CLUSTER BY customer_id, product_id, distribution_center_id, status AS
SELECT
  order_item_id,
  order_id,
  customer_id,
  product_id,
  distribution_center_id,
  order_date,
  sale_price,
  quantity,
  revenue,
  status,
  created_at
FROM `iconic-valve-310914.retail_dw.fact_sales`;
