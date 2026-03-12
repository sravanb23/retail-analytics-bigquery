# Retail Analytics Data Warehouse using BigQuery

A portfolio-ready retail analytics data warehouse built in Google BigQuery using the public TheLook E-commerce dataset.

## Project Overview
This project models transactional e-commerce data into an analytics-friendly star schema. It includes:
- Dimension tables for products, customers, distribution centers, and dates
- A fact table for sales analytics
- Data quality checks
- Optimized tables with partitioning and clustering
- A materialized view for pre-aggregated analytics
- A dashboard-facing logical view for BI tools like Looker Studio

## Tech Stack
- Google BigQuery
- SQL
- Looker Studio
- Git/GitHub

## Source Dataset
- `bigquery-public-data.thelook_ecommerce`

## Warehouse Objects
Base layer:
- `retail_dw.dim_products`
- `retail_dw.dim_customers`
- `retail_dw.dim_distribution_centers`
- `retail_dw.dim_date`
- `retail_dw.fact_sales`

Optimized layer:
- `retail_dw.dim_products_opt`
- `retail_dw.dim_customers_opt`
- `retail_dw.dim_distribution_centers_opt`
- `retail_dw.dim_date_opt`
- `retail_dw.fact_sales_opt`

Analytics layer:
- `retail_dw.mv_daily_sales_summary`
- `retail_dw.vw_daily_sales_dashboard`

## Project Structure
```text
retail_analytics_bigquery/
├── README.md
├── .gitignore
├── docs/
│   └── dashboard_plan.md
└── sql/
    ├── 01_create_dimensions.sql
    ├── 02_create_fact_sales.sql
    ├── 03_data_quality_checks.sql
    ├── 04_create_optimized_tables.sql
    ├── 05_create_materialized_view.sql
    ├── 06_create_dashboard_view.sql
    └── 07_sample_analytics_queries.sql
```

## Setup
1. Create a BigQuery dataset named `retail_dw` in your Google Cloud project.
2. Update the project id in the SQL files if needed.
3. Run the scripts in order.

## Notes
- `fact_sales_opt` is partitioned by `order_date` and clustered by common analytics keys.
- `dim_date_opt` is clustered only. It is not partitioned to avoid partition count limits.
- The dashboard should connect to `vw_daily_sales_dashboard`.

## Resume Summary
**Project Title:** Retail Analytics Data Warehouse using BigQuery

- Designed and implemented a star schema data warehouse in Google BigQuery using the TheLook E-commerce dataset, modeling fact and dimension tables to enable scalable analysis of orders, customers, and product performance.
- Developed SQL-based data transformation pipelines to aggregate transactional e-commerce data into analytical tables, enabling insights such as revenue trends, top-selling products, and customer purchasing behavior.
