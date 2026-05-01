{{ config(
    materialized='incremental',
    tags=['incremental'],
    unique_key=['match_id', 'team_id'],
    incremental_strategy='merge'
) }}

SELECT
    match_id,
    team_id,
    is_home,
    goals_for,
    goals_against,
    is_win,
    is_draw,
    is_loss,
    points
FROM {{ ref('stg_fact_team_stats') }}

{% if is_incremental() %}
-- La cláusula WHERE se utiliza para filtrar los registros que se cargarán en la tabla incremental, asegurando que solo se procesen los partidos jugados a partir de la fecha máxima de carga existente en la tabla destino.
    WHERE match_id >= (
        SELECT COALESCE(MAX(match_id), 0)
        FROM {{ this }}
    )
{% endif %}
