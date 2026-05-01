--La tabla se materializa como incremental utilizando la estrategia de merge para optimizar las cargas de datos y asegurar que solo se procesen los nuevos registros desde la última fecha cargada.
{{ config(
    materialized='incremental',
    tags=['incremental'],
    unique_key='match_id',
    incremental_strategy='merge'
) }}

SELECT
    match_id,
    match_date,
    kick_off,
    home_score,
    away_score,
    match_week,
    competition_id,
    season_id,
    stadium_id,
    referee_id,
    home_team_id,
    away_team_id
FROM {{ ref('stg_fact_matches') }}

-- La cláusula WHERE se utiliza para filtrar los registros que se cargarán en la tabla incremental, asegurando que solo se procesen los partidos jugados a partir de la fecha máxima de carga existente en la tabla destino.
{% if is_incremental() %}
    WHERE match_date >= {{ get_max_loaded_date(this) }}
{% endif %}
