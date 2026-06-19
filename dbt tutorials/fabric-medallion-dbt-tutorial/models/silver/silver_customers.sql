{{ config(materialized='table', tags=['silver']) }}

SELECT
    customer_id,
    customer_name,
    CASE 
        WHEN country IS NULL OR LTRIM(RTRIM(country)) = '' 
            THEN 'UNKNOWN'
        ELSE UPPER(country)
    END AS country
FROM {{ source('bronze', 'customers') }}
