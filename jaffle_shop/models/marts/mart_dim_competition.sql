SELECT
    competition_id,
    competition_name,
    country_id
FROM {{ ref('stg_dim_competition') }}
