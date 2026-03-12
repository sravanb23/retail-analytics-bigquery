CREATE MATERIALIZED VIEW `iconic-valve-310914.retail_dw.mv_daily_sales_summary`
AS
SELECT
  order_date,
  product_id,
  distribution_center_id,
  status,
  COUNT(*) AS line_item_count,
  SUM(quantity) AS total_units_sold,
  SUM(revenue) AS total_revenue,
  AVG(sale_price) AS avg_sale_price
FROM `iconic-valve-310914.retail_dw.fact_sales_opt`
GROUP BY
  order_date,
  product_id,
  distribution_center_id,
  status;
