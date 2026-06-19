{{ config(materialized='table', tags=['gold']) }}

SELECT
    order_date,
    SUM(quantity) AS total_quantity
FROM {{ ref('silver_orders') }}
GROUP BY order_date
