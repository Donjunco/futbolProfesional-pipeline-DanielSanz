SELECT
    stadium_id,
    stadium_name,
    country_id
FROM {{ ref('stg_dim_stadium') }}
