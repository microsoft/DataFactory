{{ config(materialized='table', tags=['gold']) }}

SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.quantity) AS total_items,
    SUM(o.quantity * p.price) AS total_spent
FROM {{ ref('silver_customers') }} c
JOIN {{ ref('silver_orders') }} o
  ON c.customer_id = o.customer_id
JOIN {{ ref('silver_products') }} p
  ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
