WITH dq_results AS (
  SELECT 'fact_sales_row_count' AS check_name, 'fact_sales' AS table_name, COUNT(*) AS issue_count
  FROM `iconic-valve-310914.retail_dw.fact_sales`
  HAVING COUNT(*) = 0

  UNION ALL
  SELECT 'fact_sales_null_order_item_id', 'fact_sales', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.fact_sales`
  WHERE order_item_id IS NULL

  UNION ALL
  SELECT 'fact_sales_duplicate_order_item_id', 'fact_sales', COUNT(*)
  FROM (
    SELECT order_item_id
    FROM `iconic-valve-310914.retail_dw.fact_sales`
    GROUP BY order_item_id
    HAVING COUNT(*) > 1
  )

  UNION ALL
  SELECT 'fact_sales_null_foreign_keys', 'fact_sales', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.fact_sales`
  WHERE order_id IS NULL OR customer_id IS NULL OR product_id IS NULL OR distribution_center_id IS NULL OR order_date IS NULL

  UNION ALL
  SELECT 'fact_sales_negative_or_zero_sale_price', 'fact_sales', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.fact_sales`
  WHERE sale_price IS NULL OR sale_price <= 0

  UNION ALL
  SELECT 'fact_sales_negative_or_zero_quantity', 'fact_sales', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.fact_sales`
  WHERE quantity IS NULL OR quantity <= 0

  UNION ALL
  SELECT 'fact_sales_negative_or_zero_revenue', 'fact_sales', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.fact_sales`
  WHERE revenue IS NULL OR revenue <= 0

  UNION ALL
  SELECT 'fact_sales_revenue_mismatch', 'fact_sales', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.fact_sales`
  WHERE ROUND(revenue, 2) != ROUND(sale_price * quantity, 2)

  UNION ALL
  SELECT 'fact_sales_future_created_at', 'fact_sales', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.fact_sales`
  WHERE created_at > CURRENT_TIMESTAMP()

  UNION ALL
  SELECT 'fact_sales_future_order_date', 'fact_sales', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.fact_sales`
  WHERE order_date > CURRENT_DATE()

  UNION ALL
  SELECT 'fact_sales_invalid_status', 'fact_sales', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.fact_sales`
  WHERE status IS NULL

  UNION ALL
  SELECT 'fact_sales_orphan_customer_fk', 'fact_sales', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.fact_sales` f
  LEFT JOIN `iconic-valve-310914.retail_dw.dim_customers` c ON f.customer_id = c.customer_id
  WHERE c.customer_id IS NULL

  UNION ALL
  SELECT 'fact_sales_orphan_product_fk', 'fact_sales', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.fact_sales` f
  LEFT JOIN `iconic-valve-310914.retail_dw.dim_products` p ON f.product_id = p.product_id
  WHERE p.product_id IS NULL

  UNION ALL
  SELECT 'fact_sales_orphan_distribution_center_fk', 'fact_sales', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.fact_sales` f
  LEFT JOIN `iconic-valve-310914.retail_dw.dim_distribution_centers` d ON f.distribution_center_id = d.distribution_center_id
  WHERE d.distribution_center_id IS NULL

  UNION ALL
  SELECT 'fact_sales_orphan_date_fk', 'fact_sales', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.fact_sales` f
  LEFT JOIN `iconic-valve-310914.retail_dw.dim_date` dd ON f.order_date = dd.date_id
  WHERE dd.date_id IS NULL

  UNION ALL
  SELECT 'dim_products_null_product_id', 'dim_products', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.dim_products`
  WHERE product_id IS NULL

  UNION ALL
  SELECT 'dim_products_duplicate_product_id', 'dim_products', COUNT(*)
  FROM (
    SELECT product_id
    FROM `iconic-valve-310914.retail_dw.dim_products`
    GROUP BY product_id
    HAVING COUNT(*) > 1
  )

  UNION ALL
  SELECT 'dim_customers_null_customer_id', 'dim_customers', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.dim_customers`
  WHERE customer_id IS NULL

  UNION ALL
  SELECT 'dim_customers_duplicate_customer_id', 'dim_customers', COUNT(*)
  FROM (
    SELECT customer_id
    FROM `iconic-valve-310914.retail_dw.dim_customers`
    GROUP BY customer_id
    HAVING COUNT(*) > 1
  )

  UNION ALL
  SELECT 'dim_distribution_centers_null_id', 'dim_distribution_centers', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.dim_distribution_centers`
  WHERE distribution_center_id IS NULL

  UNION ALL
  SELECT 'dim_distribution_centers_duplicate_id', 'dim_distribution_centers', COUNT(*)
  FROM (
    SELECT distribution_center_id
    FROM `iconic-valve-310914.retail_dw.dim_distribution_centers`
    GROUP BY distribution_center_id
    HAVING COUNT(*) > 1
  )

  UNION ALL
  SELECT 'dim_date_null_date_id', 'dim_date', COUNT(*)
  FROM `iconic-valve-310914.retail_dw.dim_date`
  WHERE date_id IS NULL

  UNION ALL
  SELECT 'dim_date_duplicate_date_id', 'dim_date', COUNT(*)
  FROM (
    SELECT date_id
    FROM `iconic-valve-310914.retail_dw.dim_date`
    GROUP BY date_id
    HAVING COUNT(*) > 1
  )
)
SELECT
  check_name,
  table_name,
  issue_count,
  CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'FAIL' END AS check_status
FROM dq_results
ORDER BY CASE WHEN issue_count = 0 THEN 2 ELSE 1 END, table_name, check_name;
