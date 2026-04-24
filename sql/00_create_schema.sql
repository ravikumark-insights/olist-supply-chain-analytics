-- ============================================================
-- 00_create_schema.sql
-- Run this in SSMS / Azure Data Studio BEFORE the ETL notebook
-- Creates the OlistSupplyChain database and documents the schema
-- ============================================================

USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'OlistSupplyChain')
    CREATE DATABASE OlistSupplyChain;
GO

USE OlistSupplyChain;
GO

-- ── SCHEMA DOCUMENTATION ────────────────────────────────────
-- Tables are created by the ETL pipeline (pandas .to_sql)
-- This file documents the expected schema for reference

/*
TABLE: fact_orders
  Primary analytical table — one row per delivered order

  order_id                  NVARCHAR  PK
  customer_id               NVARCHAR  FK → dim_customers
  primary_seller_id         NVARCHAR  FK → dim_sellers
  product_id                NVARCHAR  FK → dim_products
  
  -- Timestamps
  order_purchase_timestamp  DATETIME
  order_estimated_delivery_date DATETIME
  order_delivered_customer_date DATETIME
  
  -- Engineered delivery metrics
  delay_days                INT       (actual - estimated; negative = early)
  on_time_flag              INT       (1 = on time, 0 = late)
  is_late                   INT       (1 = late, 0 = on time)
  delay_severity            NVARCHAR  (On Time / Minor Delay / Moderate Delay / Severe Delay)
  actual_delivery_days      INT       (purchase → delivery)
  
  -- Time dimensions
  order_year                INT
  order_month               INT
  order_month_str           NVARCHAR  (YYYY-MM format for sorting)
  
  -- Revenue
  total_revenue             FLOAT
  total_freight             FLOAT
  total_payment             FLOAT
  item_count                INT
  
  -- Customer satisfaction
  review_score              FLOAT     (1–5; NULL if no review submitted)
  
  -- Location
  customer_state            NVARCHAR  (2-letter Brazilian state code)


TABLE: dim_sellers
  seller_id                 NVARCHAR  PK
  seller_zip                NVARCHAR
  seller_city               NVARCHAR
  seller_state              NVARCHAR

TABLE: dim_products
  product_id                NVARCHAR  PK
  product_category_name     NVARCHAR
  category_english          NVARCHAR
  product_weight_g          FLOAT
  product_photos_qty        INT

TABLE: dim_customers
  customer_id               NVARCHAR  PK
  customer_zip_code_prefix  NVARCHAR
  customer_city             NVARCHAR
  customer_state            NVARCHAR
*/

PRINT 'Schema documentation loaded. Run notebooks/01_etl_pipeline.ipynb to populate tables.';
GO
