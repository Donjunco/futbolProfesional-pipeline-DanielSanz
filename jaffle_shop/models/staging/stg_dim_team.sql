with

source as (

    -- {# This references seed (CSV) data - try switching to {{ source('ecom', 'raw_customers') }} #}
    select * from {{ source('raw_source', 'DIM_TEAM') }}

),

renamed as (

    select
    TEAM_ID::NUMBER as team_id,
    NULLIF(
        REGEXP_REPLACE(
            TRIM(TEAM_NAME),
            '\\s+',
            ' '
        ),
        ''
    ) AS team_name,
    TEAM_GENDER AS team_gender,
    COUNTRY_ID as country_id,
    TEAM_LOGO_URL as team_logo_url,
    from source

)

select * from renamed
