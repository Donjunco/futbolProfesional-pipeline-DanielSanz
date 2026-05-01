with

source as (

    -- {# This references seed (CSV) data - try switching to {{ source('ecom', 'raw_customers') }} #}
    select * from {{ source('raw_source', 'DIM_TEAM') }}

),

renamed as (

    select
    TEAM_ID::NUMBER as team_id,
    -- El uso de NULLIF junto con REGEXP_REPLACE y TRIM asegura que los nombres de equipo que consisten únicamente en espacios en blanco se conviertan en NULL, mientras que los nombres de equipo con espacios adicionales se limpian adecuadamente.
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
