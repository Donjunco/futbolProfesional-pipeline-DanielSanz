with

source as (

    -- {# This references seed (CSV) data - try switching to {{ source('ecom', 'raw_customers') }} #}
    select * from {{ source('raw_source', 'DIM_COMPETITION') }}

),

renamed as (

    select
    COMPETITION_ID::NUMBER as competition_id,
    NULLIF(
        REGEXP_REPLACE(
            TRIM(COMPETITION_NAME),
            '\\s+',
            ' '
        ),
        ''
    ) AS competition_name,
    COUNTRY_ID as country_id,
    from source

)

select * from renamed
