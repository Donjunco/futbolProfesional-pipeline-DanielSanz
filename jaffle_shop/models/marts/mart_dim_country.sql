SELECT
    country_id,
    country_name
FROM {{ ref('stg_dim_country') }}