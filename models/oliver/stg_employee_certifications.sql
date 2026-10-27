{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    employee_id,
    PARSE_JSON(certification_json):certification_name::varchar        AS certification_name,
    PARSE_JSON(certification_json):certification_cost::number(10,2)   AS certification_cost,
    PARSE_JSON(certification_json):certification_awarded_date::date   AS certification_awarded_date
FROM {{ source('oliver_landing', 'employee_certifications') }}