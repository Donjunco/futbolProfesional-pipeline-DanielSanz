with

source as (

    -- {# This references seed (CSV) data - try switching to {{ source('ecom', 'raw_customers') }} #}
    select * from {{ source('raw_source', 'DIM_STADIUM') }}

),

renamed as (

    select
    STADIUM_ID::NUMBER as stadium_id,
    NULLIF(
        REGEXP_REPLACE(
            TRIM(STADIUM_NAME),
            '\\s+',
            ' '
        ),
        ''
    ) AS stadium_name,
    COUNTRY_ID as country_id,
    from source

)

select * from renamed
