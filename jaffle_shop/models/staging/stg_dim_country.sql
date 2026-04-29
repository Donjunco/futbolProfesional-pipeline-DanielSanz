with

source as (

    -- {# This references seed (CSV) data - try switching to {{ source('ecom', 'raw_customers') }} #}
    select * from {{ source('raw_source', 'DIM_COUNTRY') }}

),

renamed as (

    select
    COUNTRY_ID::NUMBER as country_id,
    NULLIF(
        REGEXP_REPLACE(
            TRIM(COUNTRY_NAME),
            '\\s+',
            ' '
        ),
        ''
    ) AS country_name,
    from source

)

select * from renamed
