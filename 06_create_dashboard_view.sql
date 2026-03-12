CREATE OR REPLACE VIEW `iconic-valve-310914.retail_dw.vw_daily_sales_dashboard` AS
SELECT
  mv.order_date,
  dd.year,
  dd.quarter,
  dd.month,
  dd.day,
  dd.day_of_week,
  mv.product_id,
  p.product_name,
  p.brand,
  p.category,
  p.department,
  p.retail_price,
  mv.distribution_center_id,
  dc.name AS distribution_center_name,
  dc.latitude,
  dc.longitude,
  mv.status,
  mv.line_item_count,
  mv.total_units_sold,
  mv.total_revenue,
  mv.avg_sale_price
FROM `iconic-valve-310914.retail_dw.mv_daily_sales_summary` mv
LEFT JOIN `iconic-valve-310914.retail_dw.dim_products_opt` p
  ON mv.product_id = p.product_id
LEFT JOIN `iconic-valve-310914.retail_dw.dim_date_opt` dd
  ON mv.order_date = dd.date_id
LEFT JOIN `iconic-valve-310914.retail_dw.dim_distribution_centers_opt` dc
  ON mv.distribution_center_id = dc.distribution_center_id;
