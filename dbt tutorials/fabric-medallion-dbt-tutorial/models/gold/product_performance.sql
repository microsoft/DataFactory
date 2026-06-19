{{ config(materialized='table', tags=['gold']) }}

SELECT
    p.product_name,
    SUM(o.quantity) AS total_sold
FROM {{ ref('silver_products') }} p
JOIN {{ ref('silver_orders') }} o
  ON p.product_id = o.product_id
GROUP BY p.product_name
