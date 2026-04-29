SELECT
    manager_id,
    manager_name,
    dob,
    country_id
FROM {{ ref('stg_dim_manager') }}
