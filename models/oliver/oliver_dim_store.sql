{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT DISTINCT
    store_id AS store_key,
    store_id,
    store_name,
    street,
    city,
    state
FROM {{ source('oliver_landing', 'store') }}