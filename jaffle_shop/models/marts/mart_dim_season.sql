SELECT
    season_id,
    season_name,
FROM {{ ref('stg_dim_season') }}
