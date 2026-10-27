{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    d.date_id AS order_date,
    d.day_of_week,
    d.month,
    d.quarter,
    d.year,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.state AS customer_state,
    e.first_name || ' ' || e.last_name AS employee_name,
    e.position AS employee_position,
    s.store_name,
    s.city AS store_city,
    s.state AS store_state,
    p.product_name,
    f.quantity,
    f.unit_price,
    f.dollars_sold
FROM {{ ref('fact_sales') }} f
JOIN {{ ref('oliver_dim_date') }} d     ON f.date_key = d.date_key
JOIN {{ ref('oliver_dim_customer') }} c ON f.cust_key = c.cust_key
JOIN {{ ref('oliver_dim_employee') }} e ON f.employee_key = e.employee_key
JOIN {{ ref('oliver_dim_store') }} s    ON f.store_key = s.store_key
JOIN {{ ref('oliver_dim_product') }} p  ON f.product_key = p.product_key