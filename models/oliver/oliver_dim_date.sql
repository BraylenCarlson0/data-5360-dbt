{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    TO_NUMBER(TO_CHAR(date_day, 'YYYYMMDD')) AS date_key,
    date_day AS date_id,
    DAYNAME(date_day) AS day_of_week,
    MONTH(date_day) AS month,
    QUARTER(date_day) AS quarter,
    YEAR(date_day) AS year
FROM (
    SELECT order_date::date AS date_day
    FROM {{ source('oliver_landing', 'orders') }}
    UNION
    SELECT certification_awarded_date
    FROM {{ ref('stg_employee_certifications') }}
)