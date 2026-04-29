SELECT
    referee_id,
    referee_name,
    country_id
FROM {{ ref('stg_dim_referee') }}
