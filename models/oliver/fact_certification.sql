{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    d.date_key,
    e.employee_key,
    c.certification_name,
    c.certification_cost
FROM {{ ref('stg_employee_certifications') }} c
INNER JOIN {{ ref('oliver_dim_employee') }} e
    ON c.employee_id = e.employee_id
INNER JOIN {{ ref('oliver_dim_date') }} d
    ON d.date_key = TO_NUMBER(TO_CHAR(c.certification_awarded_date, 'YYYYMMDD'))