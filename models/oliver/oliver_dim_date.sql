{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    TO_NUMBER(TO_CHAR(order_date, 'YYYYMMDD')) AS date_key,
    order_date AS date_id,
    DAYNAME(order_date) AS day_of_week,
    MONTH(order_date) AS month,
    QUARTER(order_date) AS quarter,
    YEAR(order_date) AS year
FROM (
    SELECT DISTINCT order_date
    FROM {{ source('oliver_landing', 'orders') }}
)