with

source as (

    -- {# This references seed (CSV) data - try switching to {{ source('ecom', 'raw_customers') }} #}
    select * from {{ source('raw_source', 'FACT_TEAM_STATS') }}

),

renamed as (

    select
    MATCH_ID::NUMBER as match_id,
    TEAM_ID::NUMBER as team_id,
    IS_HOME AS is_home,
    GOALS_FOR::NUMBER as goals_for,
    GOALS_AGAINST::NUMBER as goals_against,
    IS_WIN AS is_win,
    IS_DRAW AS is_draw,
    IS_LOSS AS is_loss,
    POINTS::NUMBER as points,
    from source

)

select * from renamed
