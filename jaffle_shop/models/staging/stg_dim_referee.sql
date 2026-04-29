with

source as (

    -- {# This references seed (CSV) data - try switching to {{ source('ecom', 'raw_customers') }} #}
    select * from {{ source('raw_source', 'DIM_REFEREE') }}

),

renamed as (

    select
    REFEREE_ID::NUMBER as referee_id,
        NULLIF(
        REGEXP_REPLACE(
            TRIM(REFEREE_NAME),
            '\\s+',
            ' '
        ),
        ''
    ) AS referee_name,
    COUNTRY_ID as country_id,
    from source

)

select * from renamed
