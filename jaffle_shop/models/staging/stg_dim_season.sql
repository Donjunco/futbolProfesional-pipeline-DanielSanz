with

source as (

    -- {# This references seed (CSV) data - try switching to {{ source('ecom', 'raw_customers') }} #}
    select * from {{ source('raw_source', 'DIM_SEASON') }}

),

renamed as (

    select
    SEASON_ID::NUMBER as season_id,
    NULLIF(
        REGEXP_REPLACE(
            TRIM(SEASON_NAME),
            '\\s+',
            ' '
        ),
        ''
    ) AS season_name,
    from source

)

select * from renamed
