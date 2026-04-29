with

source as (

    -- {# This references seed (CSV) data - try switching to {{ source('ecom', 'raw_customers') }} #}
    select * from {{ source('raw_source', 'DIM_MANAGER') }}

),

renamed as (

    select
    MANAGER_ID::NUMBER as manager_id,
        NULLIF(
        REGEXP_REPLACE(
            TRIM(MANAGER_NAME),
            '\\s+',
            ' '
        ),
        ''
    ) AS manager_name,
    DOB::DATE AS dob,
    COUNTRY_ID as country_id,
    from source

)

select * from renamed
