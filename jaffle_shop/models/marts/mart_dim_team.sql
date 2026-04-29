SELECT
    team_id,
    team_name,
    team_gender,
    country_id,
    team_logo_url
FROM {{ ref('stg_dim_team') }}
