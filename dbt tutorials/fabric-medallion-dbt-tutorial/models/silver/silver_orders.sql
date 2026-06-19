{{ config(materialized='table', tags=['silver']) }}

WITH ranked AS (

    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY order_date DESC
        ) AS rn
    FROM {{ source('bronze', 'orders') }}

)

SELECT
    order_id,
    customer_id,
    product_id,
    TRY_CAST(quantity AS INT) AS quantity,
    order_date
FROM ranked
WHERE rn = 1
AND TRY_CAST(quantity AS INT) IS NOT NULL
