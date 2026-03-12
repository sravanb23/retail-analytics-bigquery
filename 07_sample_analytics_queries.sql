-- Total revenue
SELECT SUM(total_revenue) AS total_revenue
FROM `iconic-valve-310914.retail_dw.vw_daily_sales_dashboard`;

-- Monthly revenue trend
SELECT
  year,
  month,
  SUM(total_revenue) AS revenue
FROM `iconic-valve-310914.retail_dw.vw_daily_sales_dashboard`
GROUP BY year, month
ORDER BY year, month;

-- Revenue by category
SELECT
  category,
  SUM(total_revenue) AS revenue
FROM `iconic-valve-310914.retail_dw.vw_daily_sales_dashboard`
GROUP BY category
ORDER BY revenue DESC;

-- Revenue by distribution center
SELECT
  distribution_center_name,
  SUM(total_revenue) AS revenue
FROM `iconic-valve-310914.retail_dw.vw_daily_sales_dashboard`
GROUP BY distribution_center_name
ORDER BY revenue DESC;

-- Top products by revenue
SELECT
  product_name,
  brand,
  category,
  SUM(total_revenue) AS revenue,
  SUM(total_units_sold) AS units_sold
FROM `iconic-valve-310914.retail_dw.vw_daily_sales_dashboard`
GROUP BY product_name, brand, category
ORDER BY revenue DESC
LIMIT 20;
