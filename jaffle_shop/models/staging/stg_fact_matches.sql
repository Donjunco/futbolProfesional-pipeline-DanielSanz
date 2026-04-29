with

source as (

    -- {# This references seed (CSV) data - try switching to {{ source('ecom', 'raw_customers') }} #}
    select * from {{ source('raw_source', 'FACT_MATCHES') }}
),

renamed as (

    select
    MATCH_ID::NUMBER as match_id,
    MATCH_DATE::DATE as match_date,
    KICK_OFF AS kick_off,
    HOME_SCORE::NUMBER as home_score,
    AWAY_SCORE::NUMBER as away_score,
    MATCH_WEEK as match_week,
    COMPETITION_ID::NUMBER as competition_id,
    SEASON_ID::NUMBER as season_id,
    STADIUM_ID::NUMBER as stadium_id,
    REFEREE_ID::NUMBER as referee_id,
    HOME_TEAM_ID::NUMBER as home_team_id,
    AWAY_TEAM_ID::NUMBER as away_team_id,
    from source

)

select * from renamed
